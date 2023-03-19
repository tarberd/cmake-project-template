cmake_minimum_required(VERSION 3.11)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(preamble)

###############################################################################
# Create Project
###############################################################################
project(multi-repo-project)

multi_repo_add_subproject(helloworld)
multi_repo_add_subproject(hello)
