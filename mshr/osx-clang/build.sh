#!/bin/bash

if [[ "$(uname)" == "Darwin" ]]; then
export MACOSX_DEPLOYMENT_TARGET=10.9
export CXXFLAGS="-std=c++11 -stdlib=libc++ $CXXFLAGS"
export LDFLAGS="-Wl,-rpath,$PREFIX/lib $LDFLAGS"
fi

INCLUDE_PATH="$PREFIX/include"
LIBRARY_PATH="$PREFIX/lib"
CXX_FLAGS="-Wl,-rpath,$LIBRARY_PATH"
cmake \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_INCLUDE_PATH="$INCLUDE_PATH" \
  -DCMAKE_LIBRARY_PATH="$LIBRARY_PATH" \
  -DCMAKE_CXX_FLAGS="$CXX_FLAGS" \
  -DBUILD_SHARED_LIBS:BOOL=ON \
  -DENABLE_TESTS=1 \
  -DMSHR_ENABLE_VTK:BOOL=OFF\
  .
make -j${CPU_COUNT}
make install
