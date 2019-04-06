###############################################################################
# Find catch2 testing framework
###############################################################################
find_package(Catch2 REQUIRED)

# Must enable test to use ctest
enable_testing()

# Set test sources
set(sources main.cpp)

# Add test executable
add_executable(my_test ${sources})

# Link test with libraries
target_link_libraries(my_test say Catch2::Catch2)

# Add test to ctest
add_test(NAME test COMMAND my_test)
