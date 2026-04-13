APP  := controller_bench
XLEN := 64

include $(shell pwd)/../common.mk

# App-local include paths
RISCV_FLAGS += -Icompat -I. -Iinclude -Ilib
# eyalroz/printf: supports %f/%e/%g (platform printf does not)
RISCV_FLAGS += -DPRINTF_ALIAS_STANDARD_FUNCTION_NAMES_SOFT=1

SRC += filter.c \
       pid.c \
       attitude_pid_controller.c \
       position_controller_pid.c \
       controller_pid.c \
       lib/printf/printf.c \
       lib/printf/putchar_impl.c

# -lm -lgcc must follow source objects so the linker resolves math symbols
build:
	$(RISCV_GCC) $(RISCV_FLAGS) -T $(inc_dir)/test.ld -static -nostdlib -nostartfiles \
	    $(cc-elf-y) $(inc_dir)/crt.S $(inc_dir)/syscalls.c -L $(inc_dir) \
	    $(APP).c $(SRC) -o $(APP).riscv -lm -lc -lgcc
	$(info SOC_FREQ  = $(SOC_FREQ))
	$(info RISCV_FLAGS = $(RISCV_FLAGS))
