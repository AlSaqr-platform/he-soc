/*
 * putchar_ implementation for eyalroz/printf on he-soc bare-metal.
 * Delegates to uart_sendchar() used by the platform's string_lib.
 */
#include "printf.h"
#include "uart.h"

void putchar_(char c) {
  uart_sendchar(c);
}
