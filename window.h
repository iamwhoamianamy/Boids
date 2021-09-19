#pragma once
#include <iostream>
#include <vector>

#include "GL/freeglut.h"
#include "boid.h"

class Window
{
public:
   const static int WIDTH = 800;
   const static const int HEIGHT = 800;
   const static int FPS = 30;
   const double RAD = 0.0174551;

   void OnTimer(int millisec);
   void ExitingFunction();
   void Display();
   void Reshape(GLint w, GLint h);

   void KeyboardLetters(unsigned char key, int x, int y);
   void Mouse(int button, int state, int x, int y);
   void MousePassive(int x, int y);

   std::vector<Boid> boids;

   Window();

   Window(int boidsCount);
};

