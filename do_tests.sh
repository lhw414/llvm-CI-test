#!/bin/bash

# 테스트 결과를 저장할 파일
results_file="unit_tests/test_results.txt"
echo "Test Results" > $results_file

# unit_tests 디렉토리 내 모든 서브디렉토리 순회
for dir in unit_tests/*/;
do
    if [ -f "${dir}input.ll" ]; then
        echo "Testing in $dir"
        # LLVM opt를 사용하여 최적화 패스 실행
        opt -S -passes="test-optimization" "${dir}input.ll" -o "${dir}output.ll"

        # 결과 파일 확인 (여기서는 결과를 확인하지 않고 파일 생성만 확인)
        if [ -f "${dir}output.ll" ]; then
            echo "Test passed for ${dir}input.ll" >> $results_file
        else
            echo "Test failed for ${dir}input.ll" >> $results_file
        fi
    fi
done

# 결과 출력
cat $results_file
