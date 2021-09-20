#pragma once
#include "glut_functions.cuh"
#include "boid.cuh"

Window* glut_functions::window;

void glut_functions::onTimer(int millisec)
{
   if(window)
      window->OnTimer(millisec);
}

void glut_functions::exitingFunction()
{
   if(window)
      window->ExitingFunction();
}

void glut_functions::display()
{
   if(window)
      window->Display();
}

void glut_functions::reshape(GLint w, GLint h)
{
   if(window)
      window->Reshape(w, h);
}

void glut_functions::keyboardLetters(unsigned char key, int x, int y)
{
   if(window)
      window->KeyboardLetters(key, x, y);
}

void glut_functions::mouse(int button, int state, int x, int y)
{
   if(window)
      window->Mouse(button, state, x, y);
}

void glut_functions::mousePassive(int x, int y)
{
   if(window)
      window->MousePassive(x, y);
}
