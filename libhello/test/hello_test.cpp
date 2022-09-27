#include <gtest/gtest.h>
#include <hello/hello.h>

TEST(TestSuiteName, TestName2) {
  auto value = hello::new_value();
  ASSERT_EQ(value, 5);
}
