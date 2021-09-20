#pragma once
#include "cuda_runtime.h"
#include "device_error.cuh"

#ifndef DEV_PTR
#define DEV_PTR

 template <class T> class DevPtr
{
private:
   T* _data = nullptr;
   size_t _size = 0;

   DevPtr(const DevPtr&) = delete;
   DevPtr<T>(size_t size) = delete;
public:
   DevPtr();
   ~DevPtr<T>();

   T* Get() const;

   //DevPtr<T>& operator=(DevPtr<T>& devPtr);
   //T& operator[](int i);
   //const T& operator[](int i) const;

   //void CopyFromHost(const T* data);
   void CopyToHost(T* data);
   void Init(size_t size);

   size_t Size() const;
};

//template <class T>
//DevPtr<T>::DevPtr<T>(int size)
//{
//   cudaError_t result = cudaMalloc(static_cast<void**>(&_data),
//                                   size * sizeof(T));
//   if(result != cudaError_t::cudaSuccess)
//      throw MallocError;
//}

 template<class T>
 DevPtr<T>::DevPtr()
 {

 }

 template<class T>
 DevPtr<T>::~DevPtr<T>()
 {
    cudaFree(_data);
 }

 template<class T>
 void DevPtr<T>::Init(size_t size)
 {
    cudaFree(_data);
    _size = size;
    cudaError_t result = cudaMalloc((void**)&_data,
                                    size * sizeof(T));
    if(result != cudaError_t::cudaSuccess)
       throw MallocError();
 }

 template<class T>
T* DevPtr<T>::Get() const
{
   return _data;
}

template<class T>
void DevPtr<T>::CopyToHost(T* data)
{
   cudaError_t result = cudaMemcpy(data,
                                   _data,
                                   _size * sizeof(T),
                                   cudaMemcpyKind::cudaMemcpyDeviceToHost);
   if(result != cudaError_t::cudaSuccess)
      throw CopyError();
}

template<class T>
size_t DevPtr<T>::Size() const
{
   return _size;
}

#endif // ! DEV_PTR