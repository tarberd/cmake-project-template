# Template for testing libraries

This is a template for a single library in c++

## Build
``` bash
cmake -S . -B build -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
ninja -C build
```

## Test
``` bash
./build/*_test --gtest_color=true
```
