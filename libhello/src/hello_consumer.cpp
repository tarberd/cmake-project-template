#include <hello/hello.h>

namespace hello::consumer {
int new_value() { return hello::new_value() + 1; }
} // namespace hello::consumer

#include <gtest/gtest.h>

namespace hello::consumer::test {
TEST(Hello, new_value_is_6) {
  auto value = new_value();
  ASSERT_EQ(value, 5);
}
} // namespace hello::consumer::test
