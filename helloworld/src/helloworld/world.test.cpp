#include <gtest/gtest.h>

#include <helloworld/world.h>

using namespace helloworld;

TEST(WorldTest, BasicAssertions) {
  auto str = world();
  EXPECT_EQ(str, std::string_view{"World"});
}
