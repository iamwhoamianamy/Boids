#pragma once
template <class T> class DevPtr
{
private:
   T* _data;
   size_t _count;

   class MallocError{};
   class CopyError{};

public:
   DevPtr(const T* data);
   ~DevPtr();
   T* GetData() const;
   void CopyFromHost(const T* data);
   void CopyToHost(T* data);
};

