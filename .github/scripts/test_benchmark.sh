#!/bin/bash

LLVM_DIR=/opt/llvm-18.1.0/bin/

cd benchmarks/

echo "Start testing using benchmarks..."

# Check for Python3 installation and install if missing
if ! command -v python3 &>/dev/null; then
    echo "Python3 is not installed. Installing Python3..."
    sudo apt-get update && sudo apt-get install -y python3
else
    echo "Python3 is installed. Version info:"
    python3 --version
fi

# Build asms and capture output
output=$(python3 build-asms.py compiler/build/swpp-compiler 2>&1)
exit_code=$?

if [ $exit_code -ne 0 ] || [[ $output == *"Failed to build ll from"* ]]; then
    echo "Failed to build ll using swpp-compiler: $output"
    exit 1
fi

echo "Benchmarks built successfully."
