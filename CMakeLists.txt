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

# Set up testing environment
include(CTest)  # Ensure testing support is available

# Specify where the test data is located
set(TEST_DIR ${CMAKE_CURRENT_SOURCE_DIR}/unit_tests)

# Add a test configuration
add_test(NAME TestOptimization
         COMMAND lit ${TEST_DIR} -v --param llvm_site_config=${TEST_DIR}/lit.site.cfg)

# Ensure LLVM lit tool is available, check environment or set path
find_program(LIT_COMMAND lit)
if(NOT LIT_COMMAND)
  message(FATAL_ERROR "llvm-lit is not found. Please ensure LLVM tools are installed and in the PATH.")
endif()

# Add unit_tests subdirectory to CMake configuration
add_subdirectory(unit_tests)
