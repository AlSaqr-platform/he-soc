APP := kmeans
XLEN:=64

ifndef cores
cores = 1
endif

cc-elf-y += -DNUM_CORES=${cores} -w -g

cc-elf-y += -DSTATS

ifdef fmt
cc-elf-y += -D${fmt}
else
cc-elf-y += -DFP32
endif

ifdef vec
cc-elf-y += -DVECT
endif

ifdef check
cc-elf-y += -DCHECK
endif

ifdef verbose
cc-elf-y += -DVERBOSE
endif


include $(shell pwd)/../common.mk


