#pragma once
#include <iostream>
#include <vector>

#include "GL/freeglut.h"
#include "boid.cuh"
#include "dev_ptr.cuh"

#ifndef WINDOW
#define WINDOW

namespace data
{
   const int BOIDS_COUNT = 100;

   __device__ const int WIDTH = 800;
   __device__ const int HEIGHT = 800;
   __device__ const int GRID_SIZE = WIDTH * HEIGHT;
   __device__ const int IMAGE_SIZE = WIDTH * HEIGHT * 3;

   __device__ const int FPS = 30;

   __device__ const float RAD = 0.0174551f;

   __device__ const float META_RADIUS = 1.0f;
   __device__ const int HALF_IMPACT = 200;
   __device__ const int IMPACT_WIDTH = HALF_IMPACT * 2 + 1;
   __device__ const int IMPACT_THREAD_WIDTH = 32;
 
   const dim3 IMPACT_THREADS(IMPACT_THREAD_WIDTH, IMPACT_THREAD_WIDTH);
   const int THREADS_PER_BLOCK = 16;

   const dim3 BLOCKS((WIDTH  + THREADS_PER_BLOCK - 1) / THREADS_PER_BLOCK,
                     (HEIGHT + THREADS_PER_BLOCK - 1) / THREADS_PER_BLOCK);

   const dim3 THREADS(THREADS_PER_BLOCK, THREADS_PER_BLOCK);

};

typedef unsigned char uchar;

class Window
{
private:
   DevPtr<Boid> boids;
   DevPtr<uchar> dev_pixels;
   DevPtr<float> canvas;

   uchar* out_pixels = nullptr;
   //std::vector<Boid> boids;

public:
   void OnTimer(int millisec);
   void ExitingFunction();
   void Display();
   void Reshape(GLint w, GLint h);

   void KeyboardLetters(unsigned char key, int x, int y);
   void Mouse(int button, int state, int x, int y);
   void MousePassive(int x, int y);

   Window();
   Window(int boidsCount);
};

#endif // !WINDOW