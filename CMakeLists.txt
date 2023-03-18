cmake_minimum_required(VERSION 3.11)

set(CMAKE_MODULE_PATH cmake)
include(preamble)

###############################################################################
# Create Project
###############################################################################
project(multi-repo-project)

multi_repo_add_subproject(helloworld)
multi_repo_add_subproject(hello)
