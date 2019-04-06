###############################################################################
# Find catch2 testing framework
###############################################################################
find_package(Catch2 REQUIRED)

# Set test sources
set(sources main.cpp)

# Add test executable
add_executable(mytest ${sources})

# Link test with libraries
target_link_libraries(mytest mylib Catch2::Catch2)

# Add test to ctest
add_test(NAME test COMMAND mytest)
