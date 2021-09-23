#include "uart.h"
#include "spi.h"
#include "sd.h"
#include "gpt.h"

int main()
{
    init_uart(10000000, 9600);
  //  init_uart(17500000, 115200);
    print_uart("It's a boot world!\r\n");

        __asm__ volatile(
            "li s0, 0x80000000;"
            "la a1, _dtb;"
            "jr s0");

    while (1)
    {
        // do nothing
    }
}

void handle_trap(void)
{
    // print_uart("trap\r\n");
}
