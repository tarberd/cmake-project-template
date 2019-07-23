cmake_minimum_required(VERSION 3.11)

###############################################################################
# Set default CMAKE_BUILD_TYPE
###############################################################################
if(NOT CMAKE_BUILD_TYPE)
    set(default_build_type "Debug")
    string(CONCAT message
        "Setting CMAKE_BUILD_TYPE to '${default_build_type}' "
        "as none was specified."
    )
    message(STATUS ${message})
    string(CONCAT out
        "Choose the type of build, options are: "
        "None(CMAKE_CXX_FLAGS or CMAKE_C_FLAGS used) "
        "Debug Release RelWithDebInfo MinSizeRel."
    )
    set(CMAKE_BUILD_TYPE "${default_build_type}" CACHE STRING ${out} FORCE)
endif()

###############################################################################
# Create Project
###############################################################################
project(my-macro-projec VERSION 0.1.0)

set(as_subproject libhello)

macro(find_package)
    if(NOT ${ARGV0} IN_LIST as_subproject)
        _find_package(${ARGV})
    endif()
endmacro()

# Must enable test to use ctest
enable_testing()

add_subdirectory(libhello)
add_subdirectory(hello)
