
#ifdef FP32
#define FLOAT float
#define THR 0.001f
#elif defined(FP16)
#define FLOAT float16
#define THR 0.0034f
#elif defined(FP16ALT)
#define FLOAT float16alt
#ifdef VECT
#define THR 2.625f
#else
#define THR 0.172f
#endif
#endif

#ifdef VECT
#define VECTOR_MODE
#endif
 

