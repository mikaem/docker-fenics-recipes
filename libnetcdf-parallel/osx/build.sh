#!/bin/bash

if [[ "$(uname)" == "Darwin" ]]; then
  export MACOSX_DEPLOYMENT_TARGET=10.9
  export CXXFLAGS="-std=c++11 -stdlib=libc++ $CXXFLAGS"
  export LDFLAGS="-Wl,-rpath,$PREFIX/lib $LDFLAGS"
fi

if [[ "$c_compiler" == "toolchain_c" ]]; then
  # unset sysconfig patch set by other compiler package
  # which is wrong with toolchain_c registered
  unset _CONDA_PYTHON_SYSCONFIGDATA_NAME
fi

export CC=mpicc

# Build static.
cmake -D CMAKE_INSTALL_PREFIX=$PREFIX \
      -D CMAKE_INSTALL_LIBDIR:PATH=$PREFIX/lib \
      -D ENABLE_DAP=ON \
      -D ENABLE_HDF4=OFF \
      -D ENABLE_NETCDF_4=ON \
      -D ENABLE_PARALLEL_TESTS=ON \
      -D BUILD_SHARED_LIBS=OFF \
      -D ENABLE_TESTS=OFF \
      -D BUILD_UTILITIES=ON \
      -D ENABLE_DOXYGEN=OFF \
      -D ENABLE_LOGGING=ON \
      -D CURL_INCLUDE_DIR=$PREFIX/include \
      -D CURL_LIBRARY=$PREFIX/lib/libcurl.dylib \
      -D ENABLE_CDF5=ON \
      $SRC_DIR
make -j$CPU_COUNT
# ctest  # Run only for the shared lib build to save time.
make install -j$CPU_COUNT
make clean

# Build shared.
cmake -D CMAKE_INSTALL_PREFIX=$PREFIX \
      -D CMAKE_INSTALL_LIBDIR:PATH=$PREFIX/lib \
      -D ENABLE_DAP=ON \
      -D ENABLE_HDF4=OFF \
      -D ENABLE_NETCDF_4=ON \
      -D BUILD_SHARED_LIBS=ON \
      -D ENABLE_PARALLEL_TESTS=ON \
      -D ENABLE_TESTS=OFF \
      -D BUILD_UTILITIES=ON \
      -D ENABLE_DOXYGEN=OFF \
      -D ENABLE_LOGGING=ON \
      -D CURL_INCLUDE_DIR=$PREFIX/include \
      -D CURL_LIBRARY=$PREFIX/lib/libcurl.dylib \
      $SRC_DIR
make -j$CPU_COUNT
ctest
make install -j$CPU_COUNT
