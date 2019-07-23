#include <hello/hello.h>

#include <iostream>

namespace hello {
void hello(const std::string &s) { std::cout << "Hello " << s << std::endl; }
}
