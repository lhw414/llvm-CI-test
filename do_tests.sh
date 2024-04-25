#!/bin/bash

# unit_tests 디렉토리 내 모든 서브디렉토리 순회
for dir in unit_tests/*/;
do
    if [ -f "${dir}input1.ll" ]; then
        echo "Testing in $dir"

        opt -S -passes="test-optimization" "${dir}input.ll" -o "${dir}output.ll"

        if [ -f "${dir}output.ll" ]; then
            echo "Test PASSED for ${dir}input.ll"
        else
            echo "Test FAILED for ${dir}input.ll"
        fi
    fi
done
