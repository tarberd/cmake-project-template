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
# Overwrite find_package to make multi-repo work
###############################################################################
if(NOT DEFINED multi_repo_find_package)
    set(multi_repo_find_package true)
    macro(find_package)
        if(NOT ${ARGV0} IN_LIST multi_repo_subproject)
            _find_package(${ARGV})
        endif()
    endmacro()
endif()

###############################################################################
# Add subproject
###############################################################################
if(NOT DEFINED multi_repo_add_subproject)
    set(multi_repo_add_subproject true)
    macro(multi_repo_add_subproject)
        set(subproject_name ${ARGV0})
        if(NOT ${subproject_name} IN_LIST multi_repo_subproject)
            list(APPEND multi_repo_subproject ${subproject_name})
            string(CONCAT message
              "Adding subproject "
              ${subproject_name}
              " to multi-repo build."
            )
            message(STATUS ${message})
            add_subdirectory(${subproject_name})
        endif()
    endmacro()
endif()
