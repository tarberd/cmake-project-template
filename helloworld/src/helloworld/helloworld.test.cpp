#include <gtest/gtest.h>

#include <helloworld/helloworld.h>

using namespace helloworld;

TEST(HelloWorldTest, BasicAssertions) {
  auto str = hello_world();
  EXPECT_EQ(str, std::string_view{"Hello World!"});
}
