#include <hello/hello.h>

namespace hello {
int new_value2() { return 5; };
} // namespace hello

#include <gtest/gtest.h>

namespace hello::test {
TEST(Hello, new_value_is_5) {
  auto value = new_value2();
  ASSERT_EQ(value, 5);
}
} // namespace hello::test
