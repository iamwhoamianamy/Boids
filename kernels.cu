#include "kernels.cuh"
#include "help_functions.cuh"
#include "window.cuh"

namespace hlp = help_functions;

__global__ void makeMetaSpheres(const Boid* boids, float* canvas)
{
   __shared__ uint boid_id;

   __shared__ int start_x;
   __shared__ int start_y;

   if(threadIdx.x == 0 && threadIdx.y == 0)
   {
      boid_id = blockIdx.x;
      start_x = boids[boid_id].pos.x - data::HALF_IMPACT;
      start_y = boids[boid_id].pos.y - data::HALF_IMPACT;
   }

   __syncthreads();

   int offset_y = threadIdx.y;

   while(offset_y < data::IMPACT_WIDTH)
   {
      int offset_x = threadIdx.x;

      while(offset_x < data::IMPACT_WIDTH)
      {
         int x = start_x + offset_x;
         int y = start_y + offset_y;

         if(0 <= x && x < data::WIDTH &&
            0 <= y && y < data::HEIGHT)
         {
            float to_add = data::META_RADIUS *
               hlp::fisqrt((x - boids[boid_id].pos.x) * (x - boids[boid_id].pos.x) +
                           (y - boids[boid_id].pos.y) * (y - boids[boid_id].pos.y));
            //float* cell = ;

            //if(*cell + to_add <= 0.5f)
               atomicAdd(&canvas[x + y * data::WIDTH], to_add);
            //atomicAdd(&canvas[x + y * data::WIDTH], 0.5f);
         }

         __syncthreads();

         offset_x += data::IMPACT_THREAD_WIDTH;
      }
      offset_y += data::IMPACT_THREAD_WIDTH;
   }
}

__global__ void makeMetaSpheresFull(const Boid* boids, float* canvas)
{
   __shared__ uint boid_id;

   if(threadIdx.x == 0 && threadIdx.y == 0)
   {
      boid_id = blockIdx.x;
   }

   __syncthreads();

   int y = threadIdx.y;

   while(y < data::HEIGHT)
   {
      int x = threadIdx.x;

      while(x < data::WIDTH)
      {
         float to_add = data::META_RADIUS *
            hlp::fisqrt((x - boids[boid_id].pos.x) * (x - boids[boid_id].pos.x) +
                        (y - boids[boid_id].pos.y) * (y - boids[boid_id].pos.y));

         atomicAdd(&canvas[x + y * data::WIDTH], to_add);

         __syncthreads();

         x += data::IMPACT_THREAD_WIDTH;
      }
      y += data::IMPACT_THREAD_WIDTH;
   }
}

using namespace data;

__global__ void initBoids(Boid* boids, const int boidsCount)
{
   th_id i = threadIdx.x + blockIdx.x * blockDim.x;

   if(i < boidsCount)
   {
      const float step = 360.0f / boidsCount;
      const float ring_radius = WIDTH / 4;

      Vec pos = Vec(WIDTH / 2 + ring_radius * cos(i * RAD * step),
                    HEIGHT / 2 + ring_radius * sin(i * RAD * step));
      Vec vel = Vec(WIDTH / 2 - pos.x, HEIGHT / 2 - pos.y);

      vel.Limit(0.5f + 2.0f * i / boidsCount);
      boids[i] = Boid(pos, vel);
   }
}

template <class T>
__global__ void clearArray<T>(T* arr)
{
   th_id x = threadIdx.x + blockIdx.x * blockDim.x;
   th_id y = threadIdx.y + blockIdx.y * blockDim.y;
   th_id offset = x + y * blockDim.x * gridDim.x;

   arr[offset] = 0.0f;
}

__host__ void dummyKernelsTemplate()
{
   clearArray<float><<<0, 0>>>(NULL);
}

__device__ void setPixel(uchar* ptr, int offset, const uchar value)
{
   offset *= 3;
   ptr[offset + 0] = value;
   ptr[offset + 1] = value;
   ptr[offset + 2] = value;
}

__global__ void floatToColor(const float* values, uchar* colors)
{
   th_id x = threadIdx.x + blockIdx.x * blockDim.x;
   th_id y = threadIdx.y + blockIdx.y * blockDim.y;
   th_id offset = x + y * blockDim.x * gridDim.x;

   if(offset < GRID_SIZE)
   {
      uchar value;

      if(values[offset] < 0.5f)
         setPixel(colors, offset, 0);
      else
         setPixel(colors, offset, 255);

      //setPixel(colors, offset, hlp::min<uchar>(100, values[offset] * 255));
      //setPixel(colors, offset, 100);
   }
}

__global__ void moveBoids(Boid* boids, const int boidsCount)
{
   th_id i = threadIdx.x + blockIdx.x * blockDim.x;

   if(i < boidsCount)
   {
      boids[i].UpdatePosition(data::WIDTH, data::HEIGHT);
   }
}
