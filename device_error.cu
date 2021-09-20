#include "device_error.cuh"

DeviceError::DeviceError(std::string message ) : _message(message) {}
DeviceError::DeviceError() : _message("") {}

MallocError::MallocError(std::string message) : DeviceError(message) {}
MallocError::MallocError() : DeviceError("") {}

CopyError::CopyError(std::string message) : DeviceError(message) {}
CopyError::CopyError() : DeviceError("") {}
