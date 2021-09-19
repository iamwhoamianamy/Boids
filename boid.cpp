#include "boid.h"

Boid::Boid() : pos(), vel()
{

}

__device__ Boid::Boid(const Vec pos, const Vec vel) : pos(pos), vel(vel)
{
}

__device__ Boid::Boid(float px, float py, float vx, float vy) : pos(px, py), vel(vx, vy)
{
}

__device__ void Boid::UpdatePosition(float WIDTH, float height)
{
   pos += vel;

   if(pos.x < 0)
   {
      vel.x *= -1;
      pos.x = 0;
   }
   else
   {
      if(pos.x >= WIDTH)
      {
         vel.x *= -1;
         pos.x = WIDTH - 1;
      }
   }

   if(pos.y < 0)
   {
      vel.y *= -1;
      pos.y = 0;
   }
   else
   {
      if(pos.y >= height)
      {
         vel.y *= -1;
         pos.y = height - 1;
      }
   }
}
