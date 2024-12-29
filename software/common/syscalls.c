// See LICENSE for license details.

#include <stdint.h>
#include <string.h>
#include <stdarg.h>
#include <stdio.h>
#include <limits.h>
#include <sys/signal.h>
#include "util.h"
#include "utils.h"
#include "aplic.h"

#define SYS_write 64

#define IMSICM              0
#define IMSICS              1
#define IMSICVS             2

#define DELEGATE_SRC        0x400
#define INACTIVE            0
#define DETACHED            1
#define EDGE1               4
#define EDGE0               5
#define LEVEL1              6
#define LEVEL0              7

#define CSR_MIE		          0x304
#define CSR_HSTATUS		      0x600

#define CSR_MISELECT		    0x350
#define CSR_MIREG			      0x351
#define CSR_MTOPEI			    0x35c

#define CSR_SISELECT			  0x150
#define CSR_SIREG			      0x151
#define CSR_STOPEI			    0x15c

#define CSR_VSISELECT			  0x250
#define CSR_VSIREG			    0x251
#define CSR_VSTOPEI			    0x25c

#define IMSIC_EIDELIVERY		0x70
#define IMSIC_EITHRESHOLD		0x72
#define IMSIC_EIP		        0x80
#define IMSIC_EIE		        0xC0

#define APLICM_ADDR         0xc000000
#define APLICS_ADDR         0xd000000
#define DOMAIN_OFF          0x0000
#define SOURCECFG_OFF       0x0004
#define APLIC_MMSICFGADDR              0x1bc0
#define APLIC_MMSICFGADDRH             0x1bc4
#define APLIC_SMSICFGADDR              0x1bc8
#define APLIC_SMSICFGADDRH             0x1bcc
#define SETIP_OFF           0x1C00
#define SETIE_OFF           0x1E00
#define SETIPNUM_OFF        0x1CDC
#define SETIENUM_OFF        0x1EDC
#define GENMSI_OFF          0x3000
#define DEBUG_OFF          0x2008
#define TARGET_OFF          0x3004

#define IDC_OFF              0x4000
#define IDELIVERY_OFF        IDC_OFF + 0x00

#define DELEGATE_SRC            0x400



#define CSR_MHPMCOUNTER3    0xB03
#define CSR_MCOUNTINHIBIT   0x320
#define CSR_MHPMEVENT3      0x323

#define CSR_VSSTATUS 0x200
#define CSR_VSIE 0x204
#define CSR_VSTVEC 0x205
#define CSR_VSSCRATCH 0x240
#define CSR_VSEPC 0x241
#define CSR_VSCAUSE 0x242
#define CSR_VSTVAL 0x243
#define CSR_VSIP 0x244
#define CSR_VSATP 0x280

#define CSR_HSTATUS 0x600
#define CSR_HEDELEG 0x602
#define CSR_HIDELEG 0x603
#define CSR_HIE 0x604
#define CSR_HTIMEDELTA 0x605
#define CSR_HTIMEDELTAH 0x615
#define CSR_HCOUNTEREN 0x606
#define CSR_HGEIE 0x607
#define CSR_HTVAL 0x643
#define CSR_HIP 0x644
#define CSR_HVIP 0x645
#define CSR_HTINST 0x64A
#define CSR_HGATP 0x680
#define CSR_HGEIP 0xE07

#define CSR_MTINST 0x34A
#define CSR_MTVAL2 0x34B

#define STVEC_MODE_OFF (0)
#define STVEC_MODE_LEN (2)
#define STVEC_MODE_MSK BIT_MASK(STVEC_MODE_OFF, STVEC_MODE_LEN)
#define STVEC_MODE_DIRECT (0)
#define STVEC_MODE_VECTRD (1)

#if (RV64)
#define SATP_MODE_OFF (60)
#define SATP_MODE_DFLT SATP_MODE_39
#define SATP_ASID_OFF (44)
#define SATP_ASID_LEN (16)
#define HGATP_VMID_OFF (44)
#define HGATP_VMID_LEN (14)
#elif (RV32)
#define SATP_MODE_OFF (31)
#define SATP_MODE_DFLT SATP_MODE_32
#define SATP_ASID_OFF (22)
#define SATP_ASID_LEN (9)
#define HGATP_VMID_OFF (22)
#define HGATP_VMID_LEN (7)
#endif


#define MSTATUS_MPRV_OFF    (17)
#define MSTATUS_MPRV    (1ULL << MSTATUS_MPRV_OFF)
#define MSTATUS_TW_OFF  (21)
#define MSTATUS_TW   (1ULL << MSTATUS_TW_OFF)
#define MSTATUS_GVA_OFF    (38)
#define MSTATUS_GVA    (1ULL << MSTATUS_GVA_OFF)

#define SATP_MODE_BARE (0ULL << SATP_MODE_OFF)
#define SATP_MODE_32 (1ULL << SATP_MODE_OFF)
#define SATP_MODE_39 (8ULL << SATP_MODE_OFF)
#define SATP_MODE_48 (9ULL << SATP_MODE_OFF)
#define SATP_ASID_MSK BIT_MASK(SATP_ASID_OFF, SATP_ASID_LEN)

#define HGATP_MODE_OFF SATP_MODE_OFF
#define HGATP_MODE_DFLT SATP_MODE_DFLT
#define HGATP_VMID_MSK BIT_MASK(HGATP_VMID_OFF, HGATP_VMID_LEN)

#define SSTATUS_UIE_BIT (1ULL << 0)
#define SSTATUS_SIE_BIT (1ULL << 1)
#define SSTATUS_UPIE_BIT (1ULL << 4)
#define SSTATUS_SPIE_BIT (1ULL << 5)
#define SSTATUS_SPP_BIT (1ULL << 8)
#define SSTATUS_FS_OFF (13)
#define SSTATUS_FS_LEN (2)
#define SSTATUS_FS_MSK BIT_MASK(SSTATUS_FS_OFF, SSTATUS_FS_LEN)
#define SSTATUS_FS_AOFF (0)
#define SSTATUS_FS_INITIAL (1ULL << SSTATUS_FS_OFF)
#define SSTATUS_FS_CLEAN (2ULL << SSTATUS_FS_OFF)
#define SSTATUS_FS_DIRTY (3ULL << SSTATUS_FS_OFF)
#define SSTATUS_XS_OFF (15)
#define SSTATUS_XS_LEN (2)
#define SSTATUS_XS_MSK BIT_MASK(SSTATUS_XS_OFF, SSTATUS_XS_LEN)
#define SSTATUS_XS_AOFF (0)
#define SSTATUS_XS_INITIAL (1ULL << SSTATUS_XS_OFF)
#define SSTATUS_XS_CLEAN (2ULL << SSTATUS_XS_OFF)
#define SSTATUS_XS_DIRTY (3ULL << SSTATUS_XS_OFF)
#define SSTATUS_SUM (1ULL << 18)
#define SSTATUS_MXR (1ULL << 19)
#define SSTATUS_SD (1ULL << 63)

#define SIE_USIE (1ULL << 0)
#define SIE_SSIE (1ULL << 1)
#define SIE_UTIE (1ULL << 4)
#define SIE_STIE (1ULL << 5)
#define SIE_UEIE (1ULL << 8)
#define SIE_SEIE (1ULL << 9)

#define SIP_USIP SIE_USIE
#define SIP_SSIP SIE_SSIE
#define SIP_UTIP SIE_UTIE
#define SIP_STIP SIE_STIE
#define SIP_UEIP SIE_UEIE
#define SIP_SEIP SIE_SEIE

#define HIE_VSSIE (1ULL << 2)
#define HIE_VSTIE (1ULL << 6)
#define HIE_VSEIE (1ULL << 10)
#define HIE_SGEIE (1ULL << 12)

#define HIP_VSSIP HIE_VSSIE
#define HIP_VSTIP HIE_VSTIE
#define HIP_VSEIP HIE_VSEIE
#define HIP_SGEIP HIE_SGEIE

#define CAUSE_INT_BIT (1ULL << 63)
#define CAUSE_MSK (CAUSE_INT_BIT - 1)
#define CAUSE_USI (0 | CAUSE_INT_BIT)
#define CAUSE_SSI (1 | CAUSE_INT_BIT)
#define CAUSE_VSSI (2 | CAUSE_INT_BIT)
#define CAUSE_UTI (4 | CAUSE_INT_BIT)
#define CAUSE_STI (5 | CAUSE_INT_BIT)
#define CAUSE_VSTI (6 | CAUSE_INT_BIT)
#define CAUSE_UEI (8 | CAUSE_INT_BIT)
#define CAUSE_SEI (9 | CAUSE_INT_BIT)
#define CAUSE_VSEI (10 | CAUSE_INT_BIT)
#define CAUSE_IAM (0)
#define CAUSE_IAF (1)
#define CAUSE_ILI (2)
#define CAUSE_BKP (3)
#define CAUSE_LAM (4)
#define CAUSE_LAF (5)
#define CAUSE_SAM (6)
#define CAUSE_SAF (7)
#define CAUSE_ECU (8)
#define CAUSE_ECS (9)
#define CAUSE_ECV (10)
#define CAUSE_ECM (11)
#define CAUSE_IPF (12)
#define CAUSE_LPF (13)
#define CAUSE_SPF (15)
#define CAUSE_IGPF (20)
#define CAUSE_LGPF (21)
#define CAUSE_VRTI (22)
#define CAUSE_SGPF (23)

#define HIDELEG_USI SIP_USIP
#define HIDELEG_SSI SIP_SSIP
#define HIDELEG_UTI SIP_UTIP
#define HIDELEG_STI SIP_STIP
#define HIDELEG_UEI SIP_UEIP
#define HIDELEG_SEI SIP_SEIP
#define HIDELEG_VSSI HIP_VSSIP
#define HIDELEG_VSTI HIP_VSTIP
#define HIDELEG_VSEI HIP_VSEIP
#define HIDELEG_SGEI HIP_SGEIP

#define HEDELEG_IAM (1ULL << 0)
#define HEDELEG_IAF (1ULL << 1)
#define HEDELEG_ILI (1ULL << 2)
#define HEDELEG_BKP (1ULL << 3)
#define HEDELEG_LAM (1ULL << 4)
#define HEDELEG_LAF (1ULL << 5)
#define HEDELEG_SAM (1ULL << 6)
#define HEDELEG_SAF (1ULL << 7)
#define HEDELEG_ECU (1ULL << 8)
#define HEDELEG_ECS (1ULL << 9)
#define HEDELEG_ECV (1ULL << 10)
#define HEDELEG_IPF (1ULL << 12)
#define HEDELEG_LPF (1ULL << 13)
#define HEDELEG_SPF (1ULL << 15)

#define MISA_H (1ULL << 7)

#define HSTATUS_VSBE (1ULL << 5)
#define HSTATUS_GVA_OFF (6)
#define HSTATUS_GVA (1ULL << HSTATUS_GVA_OFF)
#define HSTATUS_SPV (1ULL << 7)
#define HSTATUS_SPVP (1ULL << 8)
#define HSTATUS_HU (1ULL << 9)
#define HSTATUS_VTVM (1ULL << 20)
#define HSTATUS_VTW (1ULL << 21)
#define HSTATUS_VTSR (1ULL << 22)
#define HSTATUS_VSXL_OFF (32)
#define HSTATUS_VSXL_LEN (2)
#define HSTATUS_VSXL_MSK (BIT_MASK(HSTATUS_VSXL_OFF, HSTATUS_VSXL_LEN))
#define HSTATUS_VSXL_32 (1ULL << HSTATUS_VSXL_OFF)
#define HSTATUS_VSXL_64 (2ULL << HSTATUS_VSXL_OFF)

#define HCOUNTEREN_CY   (1ULL << 0)
#define HCOUNTEREN_TM   (1ULL << 1)   
#define HCOUNTEREN_IR   (1ULL << 2)
#define HCOUNTEREN(N)   (1ULL << (N))


#define CSR_STR(s) _CSR_STR(s)
#define _CSR_STR(s) #s

#define CSRR(csr)                                     \
    ({                                                \
        uint64_t _temp;                               \
        asm volatile("csrr  %0, " CSR_STR(csr) "\n\r" \
                     : "=r"(_temp)::"memory");        \
        _temp;                                        \
    })

#define CSRW(csr, rs) \
    asm volatile("csrw  " CSR_STR(csr) ", %0\n\r" ::"rK"(rs) : "memory")
#define CSRS(csr, rs) \
    asm volatile("csrs  " CSR_STR(csr) ", %0\n\r" ::"rK"(rs) : "memory")
#define CSRC(csr, rs) \
    asm volatile("csrc  " CSR_STR(csr) ", %0\n\r" ::"rK"(rs) : "memory")

#undef strcmp

extern volatile uint64_t tohost;
extern volatile uint64_t fromhost;

static uintptr_t syscall(uintptr_t which, uint64_t arg0, uint64_t arg1, uint64_t arg2)
{
  volatile uint64_t magic_mem[8] __attribute__((aligned(64)));
  magic_mem[0] = which;
  magic_mem[1] = arg0;
  magic_mem[2] = arg1;
  magic_mem[3] = arg2;
  __sync_synchronize();

  tohost = (uintptr_t)magic_mem;
  while (fromhost == 0)
    ;
  fromhost = 0;

  __sync_synchronize();
  return magic_mem[0];
}

#define NUM_COUNTERS 2
static uintptr_t counters[NUM_COUNTERS];
static char* counter_names[NUM_COUNTERS];

void imsic_en_intp(uint8_t intp_id, uint8_t imsic_id, uint8_t core_id){
  uint32_t prev_val = 0;
  /** Config intp TARGET by writing target reg */
  // Im writing EEID to target. Only for MSI mode
  pulp_write32(APLICM_ADDR+(TARGET_OFF+(0x4*(intp_id-1))), (core_id << 18) | (0 << 12) | imsic_id);
  CSRW(CSR_MISELECT, IMSIC_EIE);
  prev_val = CSRR(CSR_MIREG);
  CSRW(CSR_MIREG, prev_val | (1 << imsic_id));
}

void setStats(int enable)
{
  int i = 0;
#define READ_CTR(name) do { \
    while (i >= NUM_COUNTERS) ; \
    uintptr_t csr = read_csr(name); \
    if (!enable) { csr -= counters[i]; counter_names[i] = #name; } \
    counters[i++] = csr; \
  } while (0)

  READ_CTR(mcycle);
  READ_CTR(minstret);

#undef READ_CTR
}

void __attribute__((noreturn)) tohost_exit(uintptr_t code)
{
  tohost = (code << 1) | 1;
  while (1);
}

void __attribute__((weak)) handle_trap(uintptr_t cause, uintptr_t epc, uintptr_t regs[32])
{
  return;
}

void exit(int code)
{
  tohost_exit(code);
}

void abort()
{
  exit(128 + SIGABRT);
}

void printstr(const char* s)
{
  syscall(SYS_write, 1, (uintptr_t)s, strlen(s));
}

void __attribute__((weak)) thread_entry(int cid, int nc)
{
  // multi-threaded programs override this function.
  // for the case of single-threaded programs, only let core 0 proceed.
  while (cid != 0)
    __asm__ volatile("wfi;");
}

int __attribute__((weak)) main(int argc, char** argv)
{
  // single-threaded programs override this function.
  return 0;
}

static void init_tls()
{
  register void* thread_pointer asm("tp");
  extern char _tls_data;
  extern __thread char _tdata_begin, _tdata_end, _tbss_end;
  size_t tdata_size = &_tdata_end - &_tdata_begin;
  memcpy(thread_pointer, &_tls_data, tdata_size);
  size_t tbss_size = &_tbss_end - &_tdata_end;
  memset(thread_pointer + tdata_size, 0, tbss_size);
}

void _init(int cid, int nc)
{
  init_tls();
  if(cid==0) {
     int * tmp;
     /* Set UART MUX with hardcoded write */
     #ifndef FPGA_EMULATION
     tmp = (int *) 0x1a104004;
     *tmp = 3;
     tmp = (int *) 0x1a10400C;
     *tmp = 3;
     int baud_rate = 115200;
     int test_freq = 100000000;
     #else
     tmp = (int *) 0x1a10407C;
     *tmp = 1;
     tmp = (int *) 0x1a104084;
     *tmp = 1;
     int baud_rate = 115200;
     int test_freq = 50000000;
     #endif
     uart_set_cfg(0,(test_freq/baud_rate)>>4);
     #ifndef FPGA_EMULATION
     set_flls();
     #endif
     /* Set plic mbox IRQ priority to 1 */
     tmp = (int *) 0xC000028;
     *tmp = 0x1;
     /* Disable interrupt from mbox scmi to core 0 */
     tmp = (int *) 0xC002080;
     *tmp = 0;
     /* Disable interrupt from mbox scmi to core 1 */
     tmp = (int *) 0xC002180;
     *tmp = 0x400;
     /* Write .text.init address in the mailbox */
     tmp = (int *) 0x10404000;
     *tmp = 0x80000000;
     /* Send interrupt to core 1 to make it jump to text_init */
     tmp = (int *) 0x10404024;
     *tmp = 1;
  }
  thread_entry(cid, nc);

  // only single-threaded programs should ever get here.
  int ret = main(0, 0);

  char buf[NUM_COUNTERS * 32] __attribute__((aligned(64)));
  char* pbuf = buf;
  for (int i = 0; i < NUM_COUNTERS; i++)
    if (counters[i])
      pbuf += sprintf(pbuf, "%s = %d\n", counter_names[i], counters[i]);
  if (pbuf != buf)
    printstr(buf);

  exit(ret);
}

#undef putchar

void printhex(uint64_t x)
{
  char str[17];
  int i;
  for (i = 0; i < 16; i++)
  {
    str[15-i] = (x & 0xF) + ((x & 0xF) < 10 ? '0' : 'a'-10);
    x >>= 4;
  }
  str[16] = 0;

  printstr(str);
}

static inline void printnum(void (*putch)(int, void**), void **putdat,
                    unsigned long long num, unsigned base, int width, int padc)
{
  unsigned digs[sizeof(num)*CHAR_BIT];
  int pos = 0;

  while (1)
  {
    digs[pos++] = num % base;
    if (num < base)
      break;
    num /= base;
  }

  while (width-- > pos)
    putch(padc, putdat);

  while (pos-- > 0)
    putch(digs[pos] + (digs[pos] >= 10 ? 'a' - 10 : '0'), putdat);
}

static unsigned long long getuint(va_list *ap, int lflag)
{
  if (lflag >= 2)
    return va_arg(*ap, unsigned long long);
  else if (lflag)
    return va_arg(*ap, unsigned long);
  else
    return va_arg(*ap, unsigned int);
}

static long long getint(va_list *ap, int lflag)
{
  if (lflag >= 2)
    return va_arg(*ap, long long);
  else if (lflag)
    return va_arg(*ap, long);
  else
    return va_arg(*ap, int);
}

static void vprintfmt(void (*putch)(int, void**), void **putdat, const char *fmt, va_list ap)
{
  register const char* p;
  const char* last_fmt;
  register int ch, err;
  unsigned long long num;
  int base, lflag, width, precision, altflag;
  char padc;

  while (1) {
    while ((ch = *(unsigned char *) fmt) != '%') {
      if (ch == '\0')
        return;
      fmt++;
      putch(ch, putdat);
    }
    fmt++;

    // Process a %-escape sequence
    last_fmt = fmt;
    padc = ' ';
    width = -1;
    precision = -1;
    lflag = 0;
    altflag = 0;
  reswitch:
    switch (ch = *(unsigned char *) fmt++) {

    // flag to pad on the right
    case '-':
      padc = '-';
      goto reswitch;

    // flag to pad with 0's instead of spaces
    case '0':
      padc = '0';
      goto reswitch;

    // width field
    case '1':
    case '2':
    case '3':
    case '4':
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
      for (precision = 0; ; ++fmt) {
        precision = precision * 10 + ch - '0';
        ch = *fmt;
        if (ch < '0' || ch > '9')
          break;
      }
      goto process_precision;

    case '*':
      precision = va_arg(ap, int);
      goto process_precision;

    case '.':
      if (width < 0)
        width = 0;
      goto reswitch;

    case '#':
      altflag = 1;
      goto reswitch;

    process_precision:
      if (width < 0)
        width = precision, precision = -1;
      goto reswitch;

    // long flag (doubled for long long)
    case 'l':
      lflag++;
      goto reswitch;

    // character
    case 'c':
      putch(va_arg(ap, int), putdat);
      break;

    // string
    case 's':
      if ((p = va_arg(ap, char *)) == NULL)
        p = "(null)";
      if (width > 0 && padc != '-')
        for (width -= strnlen(p, precision); width > 0; width--)
          putch(padc, putdat);
      for (; (ch = *p) != '\0' && (precision < 0 || --precision >= 0); width--) {
        putch(ch, putdat);
        p++;
      }
      for (; width > 0; width--)
        putch(' ', putdat);
      break;

    // (signed) decimal
    case 'd':
      num = getint(&ap, lflag);
      if ((long long) num < 0) {
        putch('-', putdat);
        num = -(long long) num;
      }
      base = 10;
      goto signed_number;

    // unsigned decimal
    case 'u':
      base = 10;
      goto unsigned_number;

    // (unsigned) octal
    case 'o':
      // should do something with padding so it's always 3 octits
      base = 8;
      goto unsigned_number;

    // pointer
    case 'p':
      static_assert(sizeof(long) == sizeof(void*));
      lflag = 1;
      putch('0', putdat);
      putch('x', putdat);
      /* fall through to 'x' */

    // (unsigned) hexadecimal
    case 'x':
      base = 16;
    unsigned_number:
      num = getuint(&ap, lflag);
    signed_number:
      printnum(putch, putdat, num, base, width, padc);
      break;

    // escaped '%' character
    case '%':
      putch(ch, putdat);
      break;

    // unrecognized escape sequence - just print it literally
    default:
      putch('%', putdat);
      fmt = last_fmt;
      break;
    }
  }
}

int virtual_printf(const char* fmt, ...)
{
  va_list ap;
  va_start(ap, fmt);

  vprintfmt((void*)putchar, 0, fmt, ap);

  va_end(ap);
  return 0; // incorrect return value, but who cares, anyway?
}

void sprintf_putch(int ch, void** data)
  {
    char** pstr = (char**)data;
    **pstr = ch;
    (*pstr)++;
  }

int sprintf(char* str, const char* fmt, ...)
{
  va_list ap;
  char* str0 = str;
  va_start(ap, fmt);

  vprintfmt(sprintf_putch, (void**)&str, fmt, ap);
  *str = 0;

  va_end(ap);
  return str - str0;
}

void* memcpy(void* dest, const void* src, size_t len)
{
  if ((((uintptr_t)dest | (uintptr_t)src | len) & (sizeof(uintptr_t)-1)) == 0) {
    const uintptr_t* s = src;
    uintptr_t *d = dest;
    while (d < (uintptr_t*)(dest + len))
      *d++ = *s++;
  } else {
    const char* s = src;
    char *d = dest;
    while (d < (char*)(dest + len))
      *d++ = *s++;
  }
  return dest;
}

void* memset(void* dest, int byte, size_t len)
{
  if ((((uintptr_t)dest | len) & (sizeof(uintptr_t)-1)) == 0) {
    uintptr_t word = byte & 0xFF;
    word |= word << 8;
    word |= word << 16;
    word |= word << 16 << 16;

    uintptr_t *d = dest;
    while (d < (uintptr_t*)(dest + len))
      *d++ = word;
  } else {
    char *d = dest;
    while (d < (char*)(dest + len))
      *d++ = byte;
  }
  return dest;
}

size_t strlen(const char *s)
{
  const char *p = s;
  while (*p)
    p++;
  return p - s;
}

size_t strnlen(const char *s, size_t n)
{
  const char *p = s;
  while (n-- && *p)
    p++;
  return p - s;
}

int strcmp(const char* s1, const char* s2)
{
  unsigned char c1, c2;

  do {
    c1 = *s1++;
    c2 = *s2++;
  } while (c1 != 0 && c1 == c2);

  return c1 - c2;
}

char* strcpy(char* dest, const char* src)
{
  char* d = dest;
  while ((*d++ = *src++))
    ;
  return dest;
}

long atol(const char* str)
{
  long res = 0;
  int sign = 0;

  while (*str == ' ')
    str++;

  if (*str == '-' || *str == '+') {
    sign = *str == '-';
    str++;
  }

  while (*str) {
    res *= 10;
    res += *str++ - '0';
  }

  return sign ? -res : res;
}
