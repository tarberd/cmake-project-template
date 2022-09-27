###############################################################################
# Find catch2 testing framework
###############################################################################
find_package(GTest REQUIRED)

# Add test executable
add_executable(hello_test hello_test.cpp)

# Link test with libraries
target_link_libraries(hello_test 
    PRIVATE libhello
    PRIVATE GTest::gtest_main
)

# Add test to ctest
add_test(NAME test_hello COMMAND hello_test)

# Add test executable
add_executable(hello_consumer_test hello_consumer_test.cpp)

# Link test with libraries
target_link_libraries(hello_consumer_test 
    PRIVATE libhello
    PRIVATE GTest::gtest_main
)

# Add test to ctest
add_test(NAME test_consumer COMMAND hello_consumer_test)
