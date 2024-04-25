#!/bin/bash

# unit_tests 디렉토리 내 모든 서브디렉토리 순회
for dir in unit_tests/*/;
do
    if [ -f "${dir}input.ll" ]; then
        echo "Testing in $dir"
        # LLVM opt를 사용하여 최적화 패스 실행
        opt -S -passes="test-optimization" "${dir}input.ll" -o "${dir}output.ll"

        # 결과 파일 존재 여부로 테스트 성공 여부 판단
        if [ -f "${dir}output.ll" ]; then
            echo "Test PASSED for ${dir}input.ll"
        else
            echo "Test FAILED for ${dir}input.ll"
        fi
    fi
done
