#pragma once

#ifndef HELP_FUNCTIONS
#define HELP_FUNCTIONS

namespace help_functions
{
   __device__ float fisqrt(const float number);

   template <class T>
   __device__ T max(T t1, T t2);

   template <class T>
   __device__ T min(T t1, T t2);
};

#endif // !HELP_FUNCTIONS