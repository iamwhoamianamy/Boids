#include <stdio.h>
#include <functional>

#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "glut_functions.cuh"
#include "kernels.cuh"

namespace glf = glut_functions;

int main(int argc, char** argv)
{
   glf::window = new Window(data::BOIDS_COUNT);

   glutInit(&argc, argv);
   glutInitDisplayMode(GLUT_RGB);
   glutInitWindowSize(data::WIDTH, data::HEIGHT);
   glutCreateWindow("Boids");

   glShadeModel(GL_FLAT);
   glPixelStorei(GL_UNPACK_ALIGNMENT, 1);

   glutDisplayFunc(glf::display);
   glutReshapeFunc(glf::reshape);
   glutKeyboardFunc(glf::keyboardLetters);
   glutMouseFunc(glf::mouse);
   glutPassiveMotionFunc(glf::mousePassive);
   atexit(glf::exitingFunction);
   glutTimerFunc(0, glf::onTimer, 0);
   glutMainLoop();

   return 0;
}