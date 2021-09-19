#pragma once
template <class T> class DevPtr
{
private:
   T* _data;
   size_t _count;

public:
   DevPtr(size_t count);
   ~DevPtr();

   T* Get() const;

   T& operator[](int i);
   const T& operator[](int i) const;

   void CopyFromHost(const T* data);
   void CopyToHost(T* data);
};

