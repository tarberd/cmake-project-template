cmake_minimum_required(VERSION 3.24)

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
# Create Project
###############################################################################
project(hello VERSION 0.1.0)

# find_package(libhello REQUIRED)
find_package(fmt REQUIRED)
find_package(range-v3 REQUIRED)

# Set target name
set(target_name hello)

###############################################################################
# Create Library
###############################################################################
# Set sources
set(sources src/main.cpp)

add_executable(${target_name} ${sources})

set_target_properties(${target_name}
    PROPERTIES
        CXX_STANDARD_REQUIRED YES
        CXX_EXTENSIONS NO
)
target_compile_features(${target_name} PRIVATE cxx_std_23)

target_link_libraries(${target_name} fmt::fmt)

###############################################################################
# Test
###############################################################################
# enable_testing()
# add_subdirectory(test)

###############################################################################
# Install rules
###############################################################################
include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

set(targets_export_name ${PROJECT_NAME}-exports)
export(TARGETS ${target_name}
    NAMESPACE ${PROJECT_NAME}::
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
    RUNTIME
        COMPONENT Runtime
        DESTINATION ${CMAKE_INSTALL_BINDIR}
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
    NAMESPACE ${PROJECT_NAME}::
    DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}/cmake
)

