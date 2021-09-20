#pragma once
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "boid.cuh"

typedef unsigned int uint;
typedef const unsigned int th_id;
typedef unsigned char uchar;

__global__ void makeMetaSpheres(const Boid* boids, float* canvas);
__global__ void makeMetaSpheresFull(const Boid* boids, float* canvas);

__global__ void initBoids(Boid* boids, const int boidsCount);

template <class T>
__global__ void clearArray(T* canvas);

__device__ void setPixel(uchar* ptr, int offset, const uchar value);

__global__ void floatToColor(const float* values, uchar* colors);

__global__ void moveBoids(Boid* boids, const int boidsCount);