APP := frontnet_bench
XLEN := 64

include $(shell pwd)/../common.mk

# App-local include paths and extra source files
RISCV_FLAGS += -Icompat -Iinclude -Ilib
# Soft-alias printf/sprintf/snprintf to the eyalroz/printf implementation,
# which supports %f/%e/%g — the platform's built-in printf does not.
RISCV_FLAGS += -DPRINTF_ALIAS_STANDARD_FUNCTION_NAMES_SOFT=1
SRC += frontnet_kf.c frontnet_ctrl.c lib/printf/printf.c lib/printf/putchar_impl.c

# Override build target: -lm -lgcc must follow the source files so the
# linker can resolve math symbols (cosf, sinf, atan2f, fmodf) that are
# referenced by the application objects.
build:
	$(RISCV_GCC) $(RISCV_FLAGS) -T $(inc_dir)/test.ld -static -nostdlib -nostartfiles $(cc-elf-y) $(inc_dir)/crt.S $(inc_dir)/syscalls.c -L $(inc_dir) $(APP).c $(SRC) -o $(APP).riscv -lm -lc -lgcc
	$(info SOC_FREQ = $(SOC_FREQ))
	$(info RISCV_FLAGS = $(RISCV_FLAGS))
