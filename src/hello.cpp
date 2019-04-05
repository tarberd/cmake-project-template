#include <hello/hello.h>

#include <iostream>

namespace hello {
    void hello(const std::string& s){
        std::cout << "hello, " << s << std::endl;
    }
}
