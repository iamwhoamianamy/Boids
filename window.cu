#include "window.cuh"
#include "glut_functions.cuh"
#include "boid.cuh"
#include "kernels.cuh"
#include "dev_ptr.cuh"

void Window::OnTimer(int millisec)
{
   glutPostRedisplay();
   glutTimerFunc(1000 / data::FPS, glut_functions::onTimer, 0);
}

void Window::ExitingFunction()
{

   std::cout << "Done!";
}

void Window::Reshape(GLint w, GLint h)
{
   glViewport(0, 0, data::WIDTH, data::HEIGHT);
   glMatrixMode(GL_PROJECTION);
   glLoadIdentity();
   glOrtho(0, data::WIDTH, 0, data::HEIGHT, -1.0, 1.0);
   glMatrixMode(GL_MODELVIEW);
   glLoadIdentity();
}

void Window::KeyboardLetters(unsigned char key, int x, int y)
{

}

void Window::Mouse(int button, int state, int x, int y)
{

}

void Window::MousePassive(int x, int y)
{

}

Window::Window()
{
   //boids.Init(0);
}

Window::Window(int boidsCount)
{
   boids.Init(boidsCount);
   dev_pixels.Init(data::IMAGE_SIZE);
   canvas.Init(data::GRID_SIZE);

   int s = canvas.Size();

   out_pixels = new uchar[data::IMAGE_SIZE];

   for(size_t i = 0; i < data::IMAGE_SIZE; i++)
      out_pixels[i] = 0;

   initBoids<<<(boidsCount + 3) / 4, 4>>>(boids.Get(), boidsCount);
}

void Window::Display()
{
   glClearColor(100, 0, 0, 255);
   glClear(GL_COLOR_BUFFER_BIT);

   clearArray<float><<<data::BLOCKS, data::THREADS>>>(canvas.Get());

   //makeMetaSpheres<<<boids.Size(), data::IMPACT_THREADS>>>(boids.Get(), canvas.Get());
   makeMetaSpheresFull<<<boids.Size(), data::IMPACT_THREADS>>>(boids.Get(), canvas.Get());

   floatToColor<<<data::BLOCKS, data::THREADS>>>(canvas.Get(), dev_pixels.Get());

   dev_pixels.CopyToHost(out_pixels);

   glRasterPos2i(0, 0);
   glDrawPixels(data::WIDTH, data::HEIGHT, GL_RGB, GL_UNSIGNED_BYTE, out_pixels);

   moveBoids<<<(boids.Size() + 3) / 4, 4>>>(boids.Get(), boids.Size());

   glFinish();
}