#include "uart.h"
#include "spi.h"
#include "sd.h"
#include "gpt.h"

int main()
{
    init_uart(10000000, 9600);
    
    print_uart("It's a boot world!\r\n");

        __asm__ volatile(
            "csrr a0, mhartid;"
            "la a1, _dtb;"
            "ebreak;");


    print_uart("Waiting the code...\r\n");
        
    while (1)
    {
        // do nothing
    }
}

void handle_trap(void)
{
    // print_uart("trap\r\n");
}
