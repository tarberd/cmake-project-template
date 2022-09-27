#include <algorithm>
#include <iterator>
#include <range/v3/range/conversion.hpp>
#include <ranges>
#include <span>
#include <string>
#include <string_view>
#include <vector>

#include <fmt/core.h>
#include <range/v3/all.hpp>

// void print_slice(std::span<int> view) {
//   fmt::print("printing view:\n");
//   for (auto v : view) {
//     fmt::print("{}\n", v);
//   }
// }

// void print_words(std::string_view view) {
//   fmt::print("printing string view\n");

//   for (auto value : view | std::ranges::views::lazy_split(' ')) {
//     fmt::print("{{");
//     for (const auto element : value) {
//       fmt::print("{}", element);
//     }
//     fmt::print("}} ");
//     fmt::print("\n");
//   };
// }

// std::vector<std::string> into_words(std::string sentence) {
//   return sentence | std::ranges::views::lazy_split(' ') |
//          std::ranges::views::transform([](auto &&word_view) -> std::string {
//            auto data = &*word_view.begin();
//            auto size =
//                static_cast<std::size_t>(std::ranges::distance(word_view));
//            return std::string{data, size};
//          }) |
//          ranges::to<std::vector<std::string>>();
// }

int main() {
  fmt::print("Hello again!\n");

  // auto my_values = std::vector{7, 2, 3, 4, 5, 6};

  // auto view = std::views::all(my_values);
  // std::ranges::sort(view);

  // fmt::print("view:\n");
  // print_slice(view);

  // fmt::print("vector:\n");
  // print_slice(my_values);

  // auto s = std::string{"foooo other fooo 123 346"};

  // fmt::print("this is a string\n");
  // auto a = into_words(std::move(s));
  // for (auto b : a) {
  //   fmt::print("{}\n", b);
  // }

  // fmt::print("this is a literal\n");
  // print_words("Hello world!");

  return 0;
}
