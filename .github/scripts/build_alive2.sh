#!/bin/bash

git clone https://github.com/AliveToolkit/alive2.git
cd alive2
git checkout 9ca7092c21e69b4e71c91b9280cff920234410dc
git apply ../.github/scripts/alive2-swpp-intrinsics.patch
cmake -GNinja -Bbuild \
    -DBUILD_TV=ON \
    -DCMAKE_PREFIX_PATH="/opt/llvm-18.1.0;/opt/z3-4.13.0" \
    -DZ3_INCLUDE_DIR=/opt/z3-4.13.0/include \
    -DZ3_LIBRARIES=/opt/z3-4.13.0/lib64/libz3.so \
    -DCMAKE_BUILD_TYPE=Release
cmake --build build