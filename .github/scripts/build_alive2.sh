#!/bin/bash

echo "Current ls:"
ls

# /opt 디렉토리의 내용 확인
echo "Contents of /opt:"
ls /opt/

# LLVM의 clang 경로를 PATH에 추가
export PATH=/opt/llvm-18.1.0/bin:$PATH

git clone https://github.com/AliveToolkit/alive2.git
cd alive2

# 현재 디렉토리 출력
echo "Current directory:"
pwd

# Build Alive2
git checkout 13266e9e163c2984f3c5de0c0961e04cb4cafc7a
git apply ../compiler/.github/scripts/alive2-swpp2024-intrinsics.patch

# cmake를 사용하여 빌드 설정, LLVM의 clang과 clang++를 사용
cmake -GNinja -Bbuild \
    -DBUILD_TV=ON \
    -DCMAKE_PREFIX_PATH="/opt/llvm-18.1.0;/opt/z3-4.13.0" \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DZ3_INCLUDE_DIR=/opt/z3-4.13.0/include \
    -DZ3_LIBRARIES=/opt/z3-4.13.0/lib/libz3.so \
    -DCMAKE_BUILD_TYPE=Release

# 빌드 실행
cmake --build build
