#include <gtest/gtest.h>

#include <helloworld/hello.h>

using namespace helloworld;

TEST(HelloTest, BasicAssertions) {
  auto str = hello();
  EXPECT_EQ(str, std::string_view{"Hello"});
}
