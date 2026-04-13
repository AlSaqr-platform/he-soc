/*
 * log.h — empty shim; logging is a NOP in bare-metal port
 */
#pragma once

#define LOG_GROUP_START(group)
#define LOG_GROUP_STOP(group)
#define LOG_ADD(type, name, var)
#define LOG_ADD_CORE(type, name, var)
#define LOG_FLOAT  0
#define LOG_INT8   1
#define LOG_UINT8  2
#define LOG_INT16  3
#define LOG_UINT16 4
#define LOG_INT32  5
#define LOG_UINT32 6
