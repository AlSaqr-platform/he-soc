#ifndef __PULP_IO_H__
#define __PULP_IO_H__

#define pulp_write32(add, val_) (*(volatile unsigned int *)(long)(add) = val_)
#define pulp_read32(add) (*(volatile unsigned int *)(long)(add))

#endif