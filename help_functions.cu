#include "cuda_runtime.h"
#include "help_functions.cuh"

__device__ float help_functions::fisqrt(const float number)
{
   long i;
   float x2, y;
   const float threehalfs = 1.5F;

   x2 = number * 0.5F;
   y = number;
   i = *(long*)&y;
   i = 0x5f3759df - (i >> 1);
   y = *(float*)&i;
   y = y * (threehalfs - (x2 * y * y));

   return y;
}

template<class T>
__device__ T help_functions::max(T t1, T t2)
{
   return t1 < t2 ? t2 : t1;
}

template<class T>
__device__ T help_functions::min(T t1, T t2)
{
   return t1 < t2 ? t1 : t2;
}

typedef unsigned char uchar;

__device__ void dummyHelpTemplate()
{
   help_functions::max<float>(0.0f, 0.0f);
   help_functions::min<float>(0.0f, 0.0f);
   help_functions::min<uchar>(0, 0);

   help_functions::max<int>(0, 0);
   help_functions::min<int>(0, 0);
   help_functions::max<uchar>(0, 0);


}
