#include "dev_ptr.h"
#include "cuda_runtime.h"

template <class T>
DevPtr<T>::DevPtr(const T* data)
{
   cudaError_t result = cudaMalloc(static_cast<void**>(&_data),
                                   _count * sizeof(T));
   if(result != cudaError_t::cudaSuccess)
      throw MallocError;
}

template<class T>
DevPtr<T>::~DevPtr()
{
   cudaFree(_data);
}

template<class T>
T* DevPtr<T>::GetData() const
{
   return *data;
}

template<class T>
void DevPtr<T>::CopyFromHost(const T* data)
{
   cudaError_t result = cudaMemcpy(static_cast<void*>(_data),
                                   static_cast<void*>(data),
                                   _count * sizeof(T),
                                   cudaMemcpyKind::cudaMemcpyHostToDevice);
   if(result != cudaError_t::cudaSuccess)
      throw CopyError;
}

template<class T>
void DevPtr<T>::CopyToHost(T* data)
{
   cudaError_t result = cudaMemcpy(static_cast<void*>(_data),
                                   static_cast<void*>(data),
                                   _count * sizeof(T),
                                   cudaMemcpyKind::cudaMemcpyHostToDevice);
   if(result != cudaError_t::cudaSuccess)
      throw CopyError;
}
