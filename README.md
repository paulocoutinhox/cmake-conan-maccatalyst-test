## Test Project

This is a test project that try compile a simple C++/Swift program with Conan as dependency manager for MacCatalyst.

[![iOS - Toolchain](https://github.com/paulocoutinhox/cmake-conan-maccatalyst-test/actions/workflows/ios-toolchain.yml/badge.svg)](https://github.com/paulocoutinhox/cmake-conan-maccatalyst-test/actions/workflows/ios-toolchain.yml)

[![Catalyst - Toolchain](https://github.com/paulocoutinhox/cmake-conan-maccatalyst-test/actions/workflows/catalyst-toolchain.yml/badge.svg)](https://github.com/paulocoutinhox/cmake-conan-maccatalyst-test/actions/workflows/catalyst-toolchain.yml)

[![iOS - Conan](https://github.com/paulocoutinhox/cmake-conan-maccatalyst-test/actions/workflows/ios-conan.yml/badge.svg)](https://github.com/paulocoutinhox/cmake-conan-maccatalyst-test/actions/workflows/ios-conan.yml)

[![Catalyst - Conan](https://github.com/paulocoutinhox/cmake-conan-maccatalyst-test/actions/workflows/catalyst-conan.yml/badge.svg)](https://github.com/paulocoutinhox/cmake-conan-maccatalyst-test/actions/workflows/catalyst-conan.yml)

## How to use

Install conan tool:

```
python3 -m pip install -r requirements.txt
```

To build for Catalyst:

```
make build-catalyst
```

To build for iOS:

```
make build-ios
```

To build with Leetal iOS Toolchain:

```
make build-catalyst-toolchain
```

## Problem

This error when build for Catalyst:

```
ld: building for Mac Catalyst, but linking in object file built for macOS, file '/Users/runner/work/cmake-conan-maccatalyst-test/cmake-conan-maccatalyst-test/build/CMakeFiles/CMakeTmp/CMAKE_TRY_COMPILE.build/Debug/cmTC_56cd2.build/Objects-normal/x86_64/main.o'
```

## License

[MIT](http://opensource.org/licenses/MIT)

Copyright (c) 2023, Paulo Coutinho
