APP := main
APP_INC := ../../inc
APP_SRC += $(wildcard ../../src/*.c)
APP_SRC += $(filter-out $(APP).c, $(wildcard *.c))

.NOTPARALLEL:

include $(SW_HOME)/common/app.mk