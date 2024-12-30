#!/bin/bash

# Di chuyển vào thư mục của dự án Flutter
cd "$(dirname "$0")"

# Kiểm tra CMake
if ! [ -x "$(command -v cmake)" ]; then
  echo "CMake không được cài đặt. Vui lòng cài đặt trước khi tiếp tục."
  exit 1
fi

# Tạo thư mục build nếu chưa tồn tại
if [ ! -d "build" ]; then
  mkdir build
fi

# Di chuyển vào thư mục build
cd build

# Chạy CMake
cmake ..

# Kiểm tra kết quả
if [ $? -eq 0 ]; then
  echo "CMake cấu hình thành công."
else
  echo "Có lỗi xảy ra khi chạy CMake."
  exit 1
fi
