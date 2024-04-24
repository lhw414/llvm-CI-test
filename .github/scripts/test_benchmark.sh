#!/bin/bash

LLVM_DIR=/opt/llvm-18.1.0/bin/

cd benchmarks/

echo "Start testing using benchmarks..."

# Build asms and capture output
output=$(python3 build-asms.py compiler/build/swpp-compiler 2>&1)
exit_code=$?

if [ $exit_code -ne 0 ] || [[ $output == *"Failed to build ll from"* ]]; then
    echo "Failed to build ll using swpp-compiler: $output"
    exit 1
fi

echo "Benchmarks built successfully."