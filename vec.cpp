#include "vec.h"

__device__ Vec::Vec() : x(0), y(0) {}
__device__ Vec::Vec(float x, float y) : x(x), y(y) {}

__device__ Vec Vec::operator +(const Vec & rhs) const
{
   Vec res;
   res.x = this->x + rhs.x;
   res.y = this->y + rhs.y;

   return res;
}


__device__ Vec Vec::operator -(const Vec & rhs) const
{
   Vec res;
   res.x = this->x - rhs.x;
   res.y = this->y - rhs.y;

   return res;
}

__device__ Vec Vec::operator *(const float fac) const
{
   Vec res;
   res.x = this->x * fac;
   res.y = this->y * fac;

   return res;
}

__device__ Vec Vec::operator /(const float fac) const
{
   Vec res;
   res.x = this->x / fac;
   res.y = this->y / fac;

   return res;
}

__device__ Vec Vec::operator +=(const Vec& rhs)
{
   this->x += rhs.x;
   this->y += rhs.y;

   return *this;
}

__device__ Vec Vec::operator -=(const Vec& rhs)
{
   this->x -= rhs.x;
   this->y -= rhs.y;

   return *this;
}

__device__ Vec& Vec::operator *=(const float fac)
{
   this->x *= fac;
   this->y *= fac;

   return *this;
}

__device__ Vec& Vec::operator /=(const float fac)
{
   if(fac != 0)
   {
      this->x /= fac;
      this->y /= fac;
   }
   else
   {
      this->x /= 0;
      this->y /= 0;
   }

   return *this;
}

__device__ float Vec::LengthSquared() const
{
   return this->x * this->x + this->y * this->y;
}

__device__ float Vec::GetLength() const
{
   return sqrtf(this->x * this->x + this->y * this->y);
}

__device__  Vec Vec::Normalized() const
{
   Vec res;
   float length = GetLength();

   if(length)
   {
      res.x = this->x / length;
      res.y = this->y / length;
   }

   return res;
}

__device__ void Vec::Normalize()
{
   float length = GetLength();

   if(length != 0)
   {
      this->x /= length;
      this->y /= length;
   }
}

__device__ void Vec::Limit(const float limitLength)
{
   float length = GetLength();

   if(length != 0 && length > limitLength)
   {
      this->x = this->x / length * limitLength;
      this->y = this->y / length * limitLength;
   }
}

__device__ void Vec::SetLength(const float newLength)
{
   Normalize();
   this->x *= newLength;
   this->y *= newLength;
}

__device__ Vec Vec::Perp() const
{
   return Vec(-y, x);
}

__device__ Vec Vec::Direction(const Vec& from, const Vec& to)
{
   Vec res = to - from;
   return res.Normalized();
}

__device__ float Vec::DistanceSquared(const Vec& vec1, const Vec& vec2)
{
   return (vec1 - vec2).LengthSquared();
}