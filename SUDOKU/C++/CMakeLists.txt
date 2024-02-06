cmake_minimum_required(VERSION 3.18)
project(project1)
include(ExternalProject)
find_package(Threads)
find_package(Git QUIET)

# Set compiler flags.
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Werror -Wextra -pedantic -pedantic-errors -g")

# Make sure we have cloned googletest.
if(GIT_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/.git")
    execute_process(COMMAND ${GIT_EXECUTABLE} -C ${PROJECT_SOURCE_DIR} submodule update --init --recursive)
    execute_process(COMMAND ${GIT_EXECUTABLE} -C ${PROJECT_SOURCE_DIR}/lib/googletest checkout tags/release-1.8.1)
endif()

# Define all testing related content here
enable_testing()

# Bring in GoogleTest
include(FetchContent)
FetchContent_Declare(googletest
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG 58d77fa8070e8cec2dc1ed015d66b454c8d78850  # release-1.12.1
        )
FetchContent_GetProperties(googletest)
if(NOT googletest_POPULATED)
    FetchContent_Populate(googletest)
    add_subdirectory(${googletest_SOURCE_DIR} ${googletest_BINARY_DIR})
endif()
include_directories(${googletest_SOURCE_DIR}/googletest/include)

# Include project headers.
include_directories(./include)

# Define the source files and dependencies for the executable.
set(SOURCE_FILES
        src/Sudoku.cpp
        src/main.cpp
        )

add_executable(main ${SOURCE_FILES})

# Define the source files and dependencies for the test executable.
set(TEST_SOURCE_FILES
        src/Sudoku.cpp
        tests/main.cpp
        tests/SudokuTest.cpp
        )

# Make the project root directory the working directory when we run.
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/bin)
add_executable(testing ${TEST_SOURCE_FILES})
add_dependencies(testing gtest)
target_link_libraries(testing gtest ${CMAKE_THREAD_LIBS_INIT})
