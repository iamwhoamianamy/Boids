#pragma once
#include "cuda_runtime.h"
#include "vec.h"

__device__ struct Boid
{
   Vec pos;
   Vec vel;

   __device__ Boid(const Vec pos, const Vec vel);
   __device__ Boid(float px, float py, float vx, float vy);

   __device__ void UpdatePosition(float width, float height);
};

