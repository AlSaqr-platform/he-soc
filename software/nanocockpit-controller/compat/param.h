/*
 * param.h — empty shim; parameter system is a NOP in bare-metal port
 */
#pragma once

#define PARAM_GROUP_START(group)
#define PARAM_GROUP_STOP(group)
#define PARAM_ADD(type, name, var)
#define PARAM_ADD_CORE(type, name, var)
#define PARAM_FLOAT      0
#define PARAM_INT8       1
#define PARAM_UINT8      2
#define PARAM_INT16      3
#define PARAM_UINT16     4
#define PARAM_INT32      5
#define PARAM_UINT32     6
#define PARAM_PERSISTENT 0
