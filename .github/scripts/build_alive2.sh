#!/bin/bash

git clone https://github.com/AliveToolkit/alive2.git
cd alive2

# Build Alive2
git checkout 13266e9e163c2984f3c5de0c0961e04cb4cafc7a
cmake -GNinja -Bbuild \
    -DBUILD_TV=ON \
    -DCMAKE_C_COMPILER=$CLANG \
    -DCMAKE_CXX_COMPILER=$CLANGXX \
    -DCMAKE_CXX_FLAGS="-stdlib=libc++" \
    -DCMAKE_EXE_LINKER_FLAGS="-stdlib=libc++ -fuse-ld=$LLD" \
    -DCMAKE_PREFIX_PATH="$LLVM_DIR;$Z3_DIR" \
    -DCMAKE_BUILD_TYPE=Release
cmake --build build