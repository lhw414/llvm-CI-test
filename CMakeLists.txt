cmake_minimum_required(VERSION 3.28.0)
project(swpp-compiler VERSION 2024.1.1)

# check if Doxygen is installed
find_package(Doxygen)
if (DOXYGEN_FOUND)
    # set input and output files
    set(DOXYGEN_IN ${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.in)
    set(DOXYGEN_OUT ${CMAKE_CURRENT_SOURCE_DIR}/docs/Doxyfile)

    # request to configure the file
    configure_file(${DOXYGEN_IN} ${DOXYGEN_OUT} @ONLY)
    message("Doxygen build started")

    add_custom_target(docs ALL
        COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_OUT}
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        COMMENT "Generating API documentation with Doxygen"
        VERBATIM )
else (DOXYGEN_FOUND)
    message("Doxygen needs to be installed to generate the doxygen documentation")
endif (DOXYGEN_FOUND)

enable_testing()

# Add tests, subdirectories, etc below
add_subdirectory(src)


enable_testing()

# Bash 스크립트를 테스트로 추가
add_test(NAME OptimizationTests COMMAND do_tests.sh)

# 테스트 종속성 확인
find_program(BASH_PROGRAM bash)
if(NOT BASH_PROGRAM)
  message(FATAL_ERROR "bash is not found on your system. Please install it to run the tests.")
endif()

# 나머지 프로젝트 설정
add_subdirectory(src)