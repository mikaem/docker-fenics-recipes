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

declare -a CMAKE_PLATFORM_FLAGS
CMAKE_PLATFORM_FLAGS+=(-DCMAKE_TOOLCHAIN_FILE="${RECIPE_DIR}/cross-linux.cmake")

export CC=mpicc

# Build static.
cmake -DCMAKE_INSTALL_PREFIX=${PREFIX} \
      -DCMAKE_INSTALL_LIBDIR="lib" \
      -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} \
      -DENABLE_DAP=ON \
      -DENABLE_HDF4=OFF \
      -DENABLE_NETCDF_4=ON \
      -DBUILD_SHARED_LIBS=OFF \
      -DENABLE_TESTS=ON \
      -DBUILD_UTILITIES=ON \
      -DENABLE_DOXYGEN=OFF \
      -DENABLE_LOGGING=ON \
      -DCMAKE_C_FLAGS_RELEASE=${CFLAGS} \
      -DCMAKE_C_FLAGS_DEBUG=${CFLAGS} \
      -DCURL_INCLUDE_DIR=${PREFIX}/include \
      -DCURL_LIBRARY=${PREFIX}/lib/libcurl${SHLIB_EXT} \
      -DENABLE_CDF5=OFF \
      ${CMAKE_PLATFORM_FLAGS[@]} \
      ${SRC_DIR}
make -j${CPU_COUNT} ${VERBOSE_CM}
# ctest  # Run only for the shared lib build to save time.
make install -j${CPU_COUNT}
make clean

# Build shared.
cmake -DCMAKE_INSTALL_PREFIX=${PREFIX} \
      -DCMAKE_INSTALL_LIBDIR="lib" \
      -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} \
      -DENABLE_DAP=ON \
      -DENABLE_HDF4=OFF \
      -DENABLE_NETCDF_4=ON \
      -DBUILD_SHARED_LIBS=ON \
      -DENABLE_TESTS=ON \
      -DBUILD_UTILITIES=ON \
      -DENABLE_DOXYGEN=OFF \
      -DENABLE_LOGGING=ON \
      -DCMAKE_C_FLAGS_RELEASE=${CFLAGS} \
      -DCMAKE_C_FLAGS_DEBUG=${CFLAGS} \
      -DCURL_INCLUDE_DIR=${PREFIX}/include \
      -DCURL_LIBRARY=${PREFIX}/lib/libcurl${SHLIB_EXT} \
      -DENABLE_CDF5=ON \
      ${CMAKE_PLATFORM_FLAGS[@]} \
      ${SRC_DIR}
make -j${CPU_COUNT} ${VERBOSE_CM}
make install -j${CPU_COUNT}
#ctest

# Leave this test where it is. ATM, conda-build deletes host prefixes by the time it runs the
# package tests which makes investigating problems very tricky. Pinging @msarahan about that.
#ncdump/ncdump -h http://geoport-dev.whoi.edu/thredds/dodsC/estofs/atlantic || exit $?

#if [[ ${c_compiler} != "toolchain_c" ]]; then
#    # Fix build paths in cmake artifacts
#    for fname in `ls ${PREFIX}/lib/cmake/netCDF/*`; do
#        sed -i.bak "s#${BUILD_PREFIX}#\$ENV\{BUILD_PREFIX\}#g" ${fname}
#        rm ${fname}.bak
#    done

#    # Fix build paths in nc-config
#    sed -i.bak "s#${BUILD_PREFIX}/bin/${CC}#${CC}#g" ${PREFIX}/bin/nc-config
#    rm ${PREFIX}/bin/nc-config.bak
#fi
