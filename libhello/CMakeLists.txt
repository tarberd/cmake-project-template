cmake_minimum_required(VERSION 3.11)

###############################################################################
# Set default CMAKE_BUILD_TYPE
###############################################################################
if(NOT DEFINED CMAKE_BUILD_TYPE)
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
# Set default BUILD_TESTS
###############################################################################
if(NOT DEFINED BUILD_TESTS)
    set(BUILD_TESTS TRUE)
    string(CONCAT message
      "Setting BUILD_TESTS to 'TRUE' "
      "as none was specified."
    )
    message(STATUS ${message})
endif()


###############################################################################
# Create Project
###############################################################################
project(libhello VERSION 0.1.0)

# Set target name and target output (lib wil be automaticaly appended)
set(target_name libhello)
set(target_output_name hello)

# Set export variables
set(targets_export_name ${PROJECT_NAME}-exports)
set(export_namespace_name ${PROJECT_NAME}::)

###############################################################################
# Create target
###############################################################################

# Set Library sources
set(sources src/hello.cpp)

add_library(${target_name} ${sources})
add_library(${export_namespace_name}${target_name} ALIAS ${target_name})

set_target_properties(${target_name} PROPERTIES
    OUTPUT_NAME ${target_output_name}
    VERSION ${PROJECT_VERSION}
    SOVERSION ${PROJECT_VERSION}
    PUBLIC_HEADER "${public_headers}"
)

target_include_directories(${target_name} PUBLIC
    $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)

target_compile_features(${target_name} PUBLIC cxx_std_17)

###############################################################################
# Test Library
###############################################################################
if(BUILD_TESTS)
    enable_testing()
    add_subdirectory(test)
endif()

###############################################################################
# Install rules
###############################################################################
include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

export(TARGETS ${target_name}
    NAMESPACE ${export_namespace_name}
    FILE ${PROJECT_BINARY_DIR}/${targets_export_name}.cmake
)

write_basic_package_version_file(
    ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake
    COMPATIBILITY SameMajorVersion
)

configure_package_config_file(
    ${PROJECT_SOURCE_DIR}/cmake/package-config.cmake.in
    ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-config.cmake
    INSTALL_DESTINATION ${CMAKE_INSTALL_DATADIRA}/${PROJECT_NAME}/cmake
)

install(TARGETS ${target_name}
    EXPORT ${targets_export_name}
    LIBRARY
        COMPONENT Libraries
        NAMELINK_COMPONENT Development
        DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE
        COMPONENT Libraries
        DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER
        COMPONENT Development
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(DIRECTORY include/${target_output_name}
    COMPONENT Development
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(
    FILES
        ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-config.cmake
        ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake
    COMPONENT Development
    DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}/cmake
)

install(EXPORT ${targets_export_name}
    COMPONENT Development
    NAMESPACE ${export_namespace_name}
    DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}/cmake
)
