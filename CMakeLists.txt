# project
cmake_minimum_required(VERSION 3.20.0)

project(xplpc LANGUAGES CXX Swift)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_Swift_LANGUAGE_VERSION 5)

# policies
cmake_policy(SET CMP0054 NEW) # only interpret if() arguments as variables or keywords when unquoted
cmake_policy(SET CMP0076 NEW) # target_sources() command converts relative paths to absolute
set(CMAKE_POLICY_DEFAULT_CMP0091 NEW) # msvc runtime library flags are selected by an abstraction
set(CMAKE_POLICY_DEFAULT_CMP0135 NEW) # set the timestamps of all extracted contents to the time of the extraction

# settings
if (NOT XCODE AND NOT MSVC AND NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

# output directories
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "bin") # .exe and .dll
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG "bin") # .exe and .dll
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE "bin") # .exe and .dll

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "lib") # .so and .dylib
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG "lib") # .so and .dylib
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "lib") # .so and .dylib

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "lib") # .lib and .a
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG "lib") # .lib and .a
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE "lib") # .lib and .a

# library
add_library(${PROJECT_NAME} SHARED
    src/lib.cpp
    src/lib.swift
)

set_source_files_properties(src/lib.swift PROPERTIES
    LANGUAGE Swift
)

target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/src)

find_library(FWK_FOUNDATION Foundation)
target_link_libraries(${PROJECT_NAME} PUBLIC ${FWK_FOUNDATION})

set_target_properties(${PROJECT_NAME} PROPERTIES
    FRAMEWORK TRUE
    FRAMEWORK_VERSION A
    MACOSX_FRAMEWORK_IDENTIFIER "com.xplpc.library"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer"
    XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH YES
    XCODE_ATTRIBUTE_SKIP_INSTALL NO
    XCODE_ATTRIBUTE_CLANG_CXX_LIBRARY "libc++"
    XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER "com.xplpc.library"
    XCODE_ATTRIBUTE_BUILD_LIBRARY_FOR_DISTRIBUTION YES
    PUBLIC_HEADER "src/lib.hpp"
)
