#include "dev_ptr.h"
#include "cuda_runtime.h"

template <class T>
DevPtr<T>::DevPtr(size_t count)
{
   cudaError_t result = cudaMalloc(static_cast<void**>(&_data),
                                   count * sizeof(T));
   if(result != cudaError_t::cudaSuccess)
      throw MallocError;
}

template<class T>
DevPtr<T>::~DevPtr()
{
   cudaFree(_data);
}

template<class T>
T* DevPtr<T>::Get() const
{
   return *data;
}

template<class T>
T& DevPtr<T>::operator[](int i)
{
   return _data[i];
}

template<class T>
const T& DevPtr<T>::operator[](int i) const
{
   return _data[i];
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
