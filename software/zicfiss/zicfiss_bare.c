//#include <stdint.h>
//#include "util.h"
//#include "params.h"
//#include "dif/clint.h"
//#include "gpt.h"
//#include "dif/uart.h"
//#include "printf.h"
#define CSR_SSP 0x011
#define CSR_HENVCFG 0x60A
#define CSR_MENVCFG 0x30A
#define CSR_SENVCFG 0x10A
#define LR_BASE 0x80008580
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "encoding.h"

int main(void) {
    
    // define Shadow Stack base addr
    // to test the ISA ext. is in a random data location
    uint64_t * ssp = (long int *)0x800084e0;
    
    // Number of iteration of Shadow Stack writes
    uint32_t ssp_iter = 4;
    
    // emulate link register content
    uint64_t lr_content[ssp_iter];
    for (int i = 0; i < ssp_iter; i++)
    	lr_content[i] = LR_BASE + i * 4;

    *ssp = 0xbaadc0de;
    
    asm volatile("csrw %0, %1"
                  :
                  : "i"(CSR_MENVCFG), "r"(8)
                  : "memory");

    asm volatile("csrw %0, %1"
                  :
                  : "i"(CSR_HENVCFG), "r"(8)
                  : "memory");

    asm volatile("csrw %0, %1"
                  :
                  : "i"(CSR_SENVCFG), "r"(8)
                  : "memory");

    // Set the machine status register (mstatus) for Supervisor Mode
    unsigned long mstatus;
    asm volatile ("csrr %0, mstatus" : "=r"(mstatus)); // Read mstatus
    mstatus &= ~MSTATUS_MPP;  // Clear MPP (Machine Previous Privilege)
    mstatus |= (1 << 11);     // Set MPP to 01 (Supervisor Mode)
    asm volatile ("csrw mstatus, %0" :: "r"(mstatus)); // Write back to mstatus
 
    // Variable to read the link register
    uint64_t lr;
    uint64_t *ssprd_check;
    set_flls();
    int baud_rate = 115200;
    int test_freq = 100000000;
    
    // Initialize UART
    uart_set_cfg(0,(test_freq/baud_rate)>>4);

    // Write shadow stack pointer CSR
    asm volatile("csrw %0, %1"
                  :
                  : "i"(CSR_SSP), "r"(ssp)
                  : "memory");

    for(int i = 0; i < 500; i++) asm volatile ("nop\n");
    
    // Read Shadow Stack pointer in t0
    asm volatile (".word 0xCDC042F3");
    for(int i = 0; i < 20; i++) asm volatile ("nop\n");
    
    // Copy Shadow Stack pointer in variable
    asm volatile (
       "mv %0, t0\n" //
       : "=r" (ssprd_check)
       :
       :
    );
    
    // Check Shadow Stack pointer read 
    if (ssprd_check == ssp)
    {
        printf("Shadow Stack pointer read correct: ssp: %x, reg content: %x\n", ssp, ssprd_check);
        uart_wait_tx_done();	
    } else {
        printf("Shadow Stack pointer read broken: ssp: %x, reg content: %x\n", ssp, ssprd_check);
        uart_wait_tx_done();
	//return 1;
    }
    
    printf("//--- Test compressed shadow stack push (on x1)\n");
    for(uint32_t i = 0; i < ssp_iter; i++){
        
        // Update shadow stack pointer in parallel
	ssp--;
        
	// load lr content in x1 to check
	asm volatile (
	    "ld x1, %0\n"
	    :
	    : "m" (lr_content[i])
	);

        // Execute a Shadow Stack Push instruction
        asm volatile(".half 0x6081");
	
        // Read Shadow Stack pointer in t0
        asm volatile (".word 0xCDC042F3");
     
	// Copy Shadow Stack pointer in variable
        asm volatile (
            "mv %0, t0\n" //
            : "=r" (ssprd_check)
            :
            :
        );
   
        printf("Compressed shadow Stack push %d: Val at address 0x%x is: 0x%x, x1 content: 0x%x, CVA6 ssp: 0x%x\n", i, (unsigned long)ssp, *ssp, lr_content[i], ssprd_check);
	uart_wait_tx_done();

        if(ssp != ssprd_check || lr_content[i] != *ssp){
            printf("early exit, failed at: %d\n", i);
            uart_wait_tx_done();
	    //return i;
        }
    }
    
    printf("//----- Test compressed shadow stack pop check (on x5)\n"); 
    for (int i = 0; i < ssp_iter; i++) 
    {   
        asm volatile (
	    "ld x5, %0\n"
	    :
	    : "m" (lr_content[ssp_iter - i - 1])
	);
 
	printf("Val at ssp 0x%x is: 0x%x, x1 content: 0x%x\n", (unsigned long)ssp, *ssp, lr_content[ssp_iter - i - 1]);
	uart_wait_tx_done();

	// Shadow Stack pop check    
        asm volatile (".half 0x6281");
        for(int j = 0; j < 50; j++) asm volatile ("nop\n");
        
        ssp++;
        	
	// Shadow stack pointer read in t0
	asm volatile (".word 0xCDC042F3");
        
	// Copy Shadow Stack pointer in variable
        asm volatile (
            "mv %0, t0\n" //
          : "=r" (ssprd_check)
          :
          :
        );

	if (ssp != ssprd_check)
	{      
             printf("Compressed Shadow Stack pop check iter %d wrong: Current CVA6 ssp: %x, GM ssp: %x\n", i, ssprd_check, ssp);
             uart_wait_tx_done();
             return i;
	}
        printf("ssppopchk iter %d ok: CVA6 ssp: %x, GM ssp: %x\n", i, ssprd_check, ssp);
	uart_wait_tx_done();

    }




    printf("//------- Test Shadow Stack Push on x1\n");
    uart_wait_tx_done();
    for(uint32_t i = 0; i < ssp_iter; i++){
        
        // Update shadow stack pointer in parallel
	ssp--;
        
	// load lr content in x1 to check
	asm volatile (
	    "ld x1, %0\n"
	    :
	    : "m" (lr_content[i])
	);

        // Execute a Shadow Stack Push instruction
        asm volatile(".word 0xCE104073");
	
        // Read Shadow Stack pointer in t0
        asm volatile (".word 0xCDC042F3");
     
	// Copy Shadow Stack pointer in variable
        asm volatile (
            "mv %0, t0\n" //
            : "=r" (ssprd_check)
            :
            :
        );
   
        printf("Shadow Stack push %d: Val at address 0x%x is: 0x%x, x1 content: 0x%x, CVA6 ssp: 0x%x\n", i, (unsigned long)ssp, *ssp, lr_content[i], ssprd_check);
	uart_wait_tx_done();

        if(ssp != ssprd_check || lr_content[i] != *ssp){
            printf("early exit, failed at: %d\n", i);
            uart_wait_tx_done();
	    return i;
        }
    }
    //------------------------------------------------------
    printf("%d SSP executed with success, current Shadow Stack pointer: %x\n", ssp_iter,(unsigned long) ssp);
    uart_wait_tx_done();

    printf("//------- Test Shadow Stack Pop Check on x1\n");
    uart_wait_tx_done();
    for (int i = 0; i < ssp_iter; i++) 
    {   
        asm volatile (
	    "ld x1, %0\n"
	    :
	    : "m" (lr_content[ssp_iter - i - 1])
	);
        
	// Shadow stack pointer read in t0
        asm volatile (".word 0xCDC042F3");

        // Copy Shadow Stack pointer in variable
        asm volatile (
            "mv %0, t0\n" //
          : "=r" (ssprd_check)
          :
          :
        );
 
	//printf("Val at ssp GM 0x%x is: 0x%x, x1 content: 0x%x, CVA6 ssp:0x%x\n", (unsigned long)ssp, *ssp, lr_content[ssp_iter - i - 1], ssprd_check);
	//uart_wait_tx_done();

	// Shadow Stack pop check    
        asm volatile (".word 0xCDC0C073");
        for(int j = 0; j < 50; j++) asm volatile ("nop\n");
        
        ssp++;
        	
	// Shadow stack pointer read in t0
	asm volatile (".word 0xCDC042F3");
        
	// Copy Shadow Stack pointer in variable
        asm volatile (
            "mv %0, t0\n" //
          : "=r" (ssprd_check)
          :
          :
        );

	if (ssp != ssprd_check)
	{      
             printf("Shadow Stack pop check iter %d wrong: Current CVA6 ssp: %x, GM ssp: %x\n", i, ssprd_check, ssp);
             uart_wait_tx_done();
             return i;
	}
        printf("ssppopchk iter %d ok: CVA6 ssp: %x, GM ssp: %x\n", i, ssprd_check, ssp);
	uart_wait_tx_done();

    }

    //---------------------------------- Test x5 as link register ---------------------------------------------------//
    printf("//------- Test Shadow Stack Push on x5\n");
    uart_wait_tx_done();
    for (int i = 0; i < ssp_iter; i++)
    {	 
        // Update shadow stack pointer in parallel
	ssp--;

	// load lr content in x1 to check
	asm volatile (
	    "ld x5, %0\n"
	    :
	    : "m" (lr_content[i])
	);

	// Shadow stack push with x5 as link register
	asm volatile (".word 0xCE504073");
 
	// Read Shadow Stack pointer in t0
        asm volatile (".word 0xCDC042F3");
     
	// Copy Shadow Stack pointer in variable
        asm volatile (
            "mv %0, t0\n" //
            : "=r" (ssprd_check)
            :
            :
        );
   
        printf("Shadow Stack push %d: Val at address 0x%x is: 0x%x, x5 content: 0x%x, CVA6 ssp: 0x%x\n", i, (unsigned long)ssp, *ssp, lr_content[i], ssprd_check);
	uart_wait_tx_done();

        if(ssp != ssprd_check || lr_content[i] != *ssp){
            printf("early exit, failed at: %d\n", i);
            uart_wait_tx_done();
	    return i;
        }
    }

    printf("//------- Test Shadow Stack Pop Check on x5\n");
    uart_wait_tx_done();
    for (int i = 0; i < ssp_iter; i++) 
    { 
 	asm volatile (
	    "ld x5, %0\n"
	    :
	    : "m" (lr_content[ssp_iter - i - 1])
	);

	printf("Val at ssp 0x%x is: 0x%x, x5 content: 0x%x\n", (unsigned long)ssp, *ssp, lr_content[ssp_iter - i - 1]);
	uart_wait_tx_done();

	// Shadow Stack pop check in x5    
        asm volatile (".word 0xCDC2C073");
        for(int j = 0; j < 50; j++) asm volatile ("nop\n");
        
        ssp++;
        	
	// Shadow stack pointer read in t0
        asm volatile (".word 0xCDC042F3");
        
	// Copy Shadow Stack pointer in variable
        asm volatile (
            "mv %0, t0\n" //
          : "=r" (ssprd_check)
          :
          :
        );

	if (ssp != ssprd_check)
	{      
             printf("Shadow Stack pop check iter %d wrong: Current CVA6 ssp: %x, GM ssp: %x\n", i, ssprd_check, ssp);
             uart_wait_tx_done();
             return i;
	}
        printf("ssppopchk iter %d ok: CVA6 ssp: %x, GM ssp: %x\n", i, ssprd_check, ssp); 
	uart_wait_tx_done();
    }

    return 0;
}

