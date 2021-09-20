#pragma once
#include <cmath>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#ifndef VEC
#define VEC

__device__ struct Vec
{
   float x;
   float y;

   __device__ Vec();
   __device__ Vec(const Vec& vec);
   __device__ Vec(float x, float y);

   __device__ Vec operator +(const Vec& rhs) const;
   __device__ Vec operator -(const Vec& rhs) const;
   __device__ Vec operator *(const float fac) const;
   __device__ Vec operator /(const float fac) const;

   __device__ Vec operator +=(const Vec& rhs);
   __device__ Vec operator -=(const Vec& rhs);
   __device__ Vec& operator *=(const float fac);
   __device__ Vec& operator /=(const float fac);

   __device__ float LengthSquared() const;
   __device__ float GetLength() const;
   __device__ Vec Normalized() const;
   __device__ Vec Perp() const;

   __device__ void Normalize();
   __device__ void Limit(const float limitLength);
   __device__ void SetLength(const float newLength);

   __device__ static Vec Direction(const Vec& from, const Vec& to);
   __device__ static float DistanceSquared(const Vec& vec1, const Vec& vec2);
};

#endif // !VEC