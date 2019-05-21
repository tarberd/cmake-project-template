# Cmake project template

This template supports any numer of subproject for libraries and executables.

Every subproject is self-contained and can be isolated with no changes needed.

This project can be viewd as macroproject of many selfcontained projects.

# Build as Macro project
``` bash
mkdir build
cd build
cmake ..
make
```

## Test 
``` bash
cd build
make test
```

# Build one project at a time
```
cd mylib
mkdir build && cd build
cmake ..
make -j
make install
```

```
cd mybin
mkdir build && cd build
cmake ..
make -j
make install
```
