#!/bin/bash

echo "Current ls:"
ls

git clone https://github.com/AliveToolkit/alive2.git
cd alive2

# 현재 디렉토리 출력
echo "Current directory:"
pwd

# Build Alive2
git checkout 13266e9e163c2984f3c5de0c0961e04cb4cafc7a
git apply ../.github/scripts/alive2-swpp2024-intrinsics.patch
cmake -GNinja -Bbuild \
    -DBUILD_TV=ON \
    -DCMAKE_PREFIX_PATH="/opt/llvm-18.1.0;/opt/z3-4.13.0" \
    -DZ3_INCLUDE_DIR=/opt/z3-4.13.0/include \
    -DZ3_LIBRARIES=/opt/z3-4.13.0/lib/libz3.so \
    -DCMAKE_BUILD_TYPE=Release
cmake --build build