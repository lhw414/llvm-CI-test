cmake_minimum_required(VERSION 3.28.0)
project(swpp-compiler VERSION 2024.1.1)

# Doxygen 설정
find_package(Doxygen)
if (DOXYGEN_FOUND)
    set(DOXYGEN_IN ${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.in)
    set(DOXYGEN_OUT ${CMAKE_CURRENT_SOURCE_DIR}/docs/Doxyfile)
    configure_file(${DOXYGEN_IN} ${DOXYGEN_OUT} @ONLY)
    message("Doxygen build started")
    add_custom_target(docs ALL
        COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_OUT}
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        COMMENT "Generating API documentation with Doxygen"
        VERBATIM )
else ()
    message("Doxygen needs to be installed to generate the doxygen documentation")
endif ()

# 서브디렉토리 추가
add_subdirectory(src)

# # 테스트 환경 설정
# enable_testing()
# find_program(BASH_PROGRAM bash)
# if(NOT BASH_PROGRAM)
#     message(FATAL_ERROR "bash is not found on your system. Please install it to run the tests.")
# endif()

# # 쉘 스크립트 테스트 추가
# add_test(NAME OptimizationTests COMMAND ${BASH_PROGRAM} ${CMAKE_CURRENT_SOURCE_DIR}/do_tests.sh ~/llvm-18.1.0/bin)
