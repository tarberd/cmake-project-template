#include <gtest/gtest.h>
#include <hello/hello_consumer.h>

TEST(TestSuiteName, TestName) {
  auto value = hello::consumer::new_value();
  ASSERT_EQ(value, 6);
}
