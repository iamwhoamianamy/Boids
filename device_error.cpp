#include "device_error.h"

DeviceError::DeviceError(std::string message ) : _message(message) {}

MallocError::MallocError(std::string message) : DeviceError(message) {}

CopyError::CopyError(std::string message) : DeviceError(message) {}
