cmake_minimum_required(VERSION 3.11)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(preamble)

###############################################################################
# Create Project
###############################################################################
project(helloworld VERSION 0.1.0)

###############################################################################
# Create target
###############################################################################

# Set target name and target output name
set(target_name helloworld)
set(target_output_name helloworld)

# Set export variables
set(targets_export_name ${PROJECT_NAME}-exports)
set(export_namespace_name ${PROJECT_NAME}::)
set(namespace_qualified_target_name ${export_namespace_name}${target_output_name})

# Set Library sources
set(sources
    src/helloworld/hello.cpp
    src/helloworld/world.cpp
    src/helloworld/helloworld.cpp
)

add_library(${target_name} ${sources})
add_library(${export_namespace_name}${target_output_name} ALIAS ${target_name})

set_target_properties(${target_name} PROPERTIES
    OUTPUT_NAME ${target_output_name}
    VERSION ${PROJECT_VERSION}
    SOVERSION ${PROJECT_VERSION}
)

target_include_directories(${target_name} PUBLIC
    $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)

target_compile_features(${target_name} PUBLIC cxx_std_20)

###############################################################################
# Unit testing
###############################################################################
if(BUILD_TESTS)
    find_package(GTest)

    set(test_sources
        src/helloworld/hello.test.cpp
        src/helloworld/world.test.cpp
        src/helloworld/helloworld.test.cpp
    )

    add_executable(${target_name}_test ${test_sources})

    target_link_libraries(${target_name}_test
        PRIVATE ${namespace_qualified_target_name}
        PRIVATE GTest::gtest_main
    )

    target_compile_features(${target_name} PUBLIC cxx_std_20)
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
