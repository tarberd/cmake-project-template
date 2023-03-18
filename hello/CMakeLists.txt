cmake_minimum_required(VERSION 3.11)

set(CMAKE_MODULE_PATH cmake)
include(preamble)

###############################################################################
# Create Project
###############################################################################
project(hello VERSION 0.1.0)

find_package(helloworld REQUIRED)


###############################################################################
# Create Library
###############################################################################

# Set target name
set(target_name hello)

# Set sources
set(sources src/hello.main.cpp)

add_executable(${target_name} ${sources})

target_compile_features(${target_name} PRIVATE cxx_std_20)

target_link_libraries(${target_name} helloworld::helloworld)

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
