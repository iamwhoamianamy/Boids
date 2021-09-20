#pragma once
#include "vec.cuh"

#ifndef BOID
#define BOID

__device__ class Boid
{
public:
   Vec pos;
   Vec vel;

   __device__ Boid();
   __device__ Boid(const Vec& pos, const Vec& vel);
   __device__ Boid(float px, float py, float vx, float vy);
   __device__ void UpdatePosition(float width, float height);
};


#endif // !BOID