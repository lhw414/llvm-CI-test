# #!/bin/bash

# llvm_path="$1"
# alive_tv_binary="$2"
# passes_dir='./src/lib/opt'
# ll_files_dir='./unit_tests'
# temp_dir_path='./tmp'

# # Cleanup and prepare temporary directory
# rm -rf "$temp_dir_path"
# mkdir -p "$temp_dir_path"

# # Read entries
# while IFS=, read -r sourcename classname passname; do
#     test_input_dir="$ll_files_dir/$sourcename"
#     test_output_dir="$temp_dir_path/$sourcename"
#     mkdir -p "$test_output_dir"

#     echo "Testing pass: $passname"
#     pass_lib="lib${classname}.so"

#     for ll_file in $(find "$test_input_dir" -name "*.ll"); do
#         echo "Testing file: $ll_file"

#         output_file="$test_output_dir/out.$(basename $ll_file)"
#         log_file="$output_file.log"
#         alive_log_file="$output_file.alive"

#         # Run opt with the pass shared library
#         opt_cmd="$llvm_path/bin/opt -load-pass-plugin=./build/$pass_lib -passes=$passname $ll_file -S -o $output_file"
#         echo "$opt_cmd"
#         if ! $opt_cmd > "$log_file" 2>&1; then
#             echo "Opt command failed for $ll_file"
#             continue
#         fi

#         # Run filecheck on the output
#         filecheck_cmd="$llvm_path/bin/FileCheck $ll_file"
#         echo "$filecheck_cmd"
#         if ! $filecheck_cmd < "$output_file" > /dev/null 2>&1; then
#             echo "FileCheck failed for $ll_file"
#             continue
#         fi

#         # Run alive2 validation on the output
#         alive2_cmd="$alive_tv_binary $ll_file $output_file"
#         echo "$alive2_cmd"
#         if ! $alive2_cmd > "$alive_log_file" 2>&1; then
#             echo "Alive2 validation failed for $ll_file"
#             continue
#         fi

#         # Check alive2 summary
#         if grep -q "incorrect transformations" "$alive_log_file"; then
#             echo "Alive2 found incorrect transformations for $ll_file"
#         fi
#     done
# done < "$ll_files_dir/entries.csv"


#!/bin/bash

llvm_path="$1"
passes_dir='./src/lib/opt'
ll_files_dir='./unit_tests'
temp_dir_path='./tmp'

# Cleanup and prepare temporary directory
rm -rf "$temp_dir_path"
mkdir -p "$temp_dir_path"

# Read entries
while IFS=, read -r sourcename classname passname; do
    test_input_dir="$ll_files_dir/$sourcename"
    test_output_dir="$temp_dir_path/$sourcename"
    mkdir -p "$test_output_dir"

    echo "Testing pass: $passname"
    pass_lib="lib${classname}.so"

    for ll_file in $(find "$test_input_dir" -name "*.ll"); do
        echo "Testing file: $ll_file"

        output_file="$test_output_dir/out.$(basename $ll_file)"
        log_file="$output_file.log"

        # Run opt with the pass shared library
        opt_cmd="$llvm_path/bin/opt -load-pass-plugin=./build/$pass_lib -passes=$passname $ll_file -S -o $output_file"
        echo "$opt_cmd"
        if ! $opt_cmd > "$log_file" 2>&1; then
            echo "Opt command failed for $ll_file"
            continue
        fi

        # Run filecheck on the output
        filecheck_cmd="$llvm_path/bin/FileCheck $ll_file"
        echo "$filecheck_cmd"
        if ! $filecheck_cmd < "$output_file" > /dev/null 2>&1; then
            echo "FileCheck failed for $ll_file"
            continue
        fi

        echo "Test passed for $ll_file"
    done
done < "$ll_files_dir/entries.csv"
