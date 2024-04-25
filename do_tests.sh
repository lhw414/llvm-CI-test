#!/bin/bash

# unit_tests 디렉토리 내 모든 서브디렉토리 순회
for dir in unit_tests/*/;
do
    if [ -f "${dir}input.ll" ]; then
        echo "Testing in $dir"

        # 최적화 명령 실행 및 오류 로그 저장
        opt -S -passes="test-optimization" "${dir}input.ll" -o "${dir}output.ll" 2>"${dir}error.log"

        # opt 명령의 종료 코드 확인
        if [ $? -eq 0 ] && [ -s "${dir}output.ll" ]; then
            echo "Test PASSED for ${dir}input.ll"
        else
            echo "Test FAILED for ${dir}input.ll"
            cat "${dir}error.log"
        fi
    fi
done
