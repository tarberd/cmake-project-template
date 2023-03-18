# Cmake project template

This template implements a modern multi-repo approach for modern C++ libraries and executables and can easily be adapted to a mono-repo if single target is desired.

Every multi-repo subproject is self-contained and can be isolated with no changes needed (except the preamble.cmake module).

# Build as multi-repo project
``` bash
cmake -S . -B build -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
ninja -C build
```

## Test
``` bash
./build/<subproject>/*_test --gtest_color=true
```

# Build one project at a time
```
cmake -S <path_to_subproject> -B build -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
```

# References:

Project layouts are based on the [pitchfork](https://github.com/vector-of-bool/pitchfork) proposal.

CMakelist file architecture inspired by the great talk by Daniel Pfeifer [Effective Cmake](https://youtu.be/bsXLMQ6WgIk).
