#pragma once
#include <string>

class DeviceError
{
private:
   std::string _message;
public:
   DeviceError(std::string message);
   DeviceError();
};

class MallocError : public DeviceError
{
public:
   MallocError(std::string message);
   MallocError();
};

class CopyError : public DeviceError
{
public:
   CopyError(std::string message);
   CopyError();
};