#include "glut_functions.h"
#include "window.h"

void Window::OnTimer(int millisec)
{
   glutPostRedisplay();
   glutTimerFunc(1000 / FPS, glut_functions::onTimer, 0);
}

void Window::ExitingFunction()
{

   std::cout << "Done!";
}

void Window::Display()
{
   glClearColor(0, 0, 0, 255);
   glClear(GL_COLOR_BUFFER_BIT);
   

   for(size_t i = 0; i < boids.size(); i++)
   {
      boids[i].UpdatePosition(WIDTH, HEIGHT);
   }

   glBegin(GL_POINTS);
   for(size_t i = 0; i < boids.size(); i++)
   {
      glColor3f(1.0f, 1.0f, 1.0f);
      glVertex2d(boids[i].pos.x, boids[i].pos.y);
   }
   glEnd();

   glFinish();
}

void Window::Reshape(GLint w, GLint h)
{
   glViewport(0, 0, WIDTH, HEIGHT);
   glMatrixMode(GL_PROJECTION);
   glLoadIdentity();
   glOrtho(0, WIDTH, 0, HEIGHT, -1.0, 1.0);
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
}

Window::Window(int boidsCount)
{
   boids = std::vector<Boid>(boidsCount);

   for(size_t i = 0; i < boidsCount; i++)
   {
      const float step = 360.0f / boidsCount;
      const float ring_radius = WIDTH / 4;
      Vec pos = Vec(WIDTH / 2 + ring_radius * cos(i * RAD * step),
                    HEIGHT / 2 + ring_radius * sin(i * RAD * step));
      Vec vel = Vec(WIDTH / 2 - pos.x, HEIGHT / 2 - pos.y);
      vel.Limit(1.0f);
      boids[i] = Boid(pos, vel);
   }
}
