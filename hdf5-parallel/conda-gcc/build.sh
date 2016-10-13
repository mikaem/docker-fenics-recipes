#!/bin/bash

if [ "$(uname)" == "Darwin" ]
then
    export CXX=mpicxx
    export CXXFLAGS="-stdlib=libc++ ${CXXFLAGS}"
    export LDFLAGS="-Wl,-rpath,$PREFIX/lib"
fi

export LIBRARY_PATH="${PREFIX}/lib"

#./configure --prefix="${PREFIX}" \
#            --enable-linux-lfs \
#            --with-zlib="${PREFIX}" \
#            --with-pthread=yes  \
#            --enable-cxx \
#            --enable-fortran \
#            --with-default-plugindir="${PREFIX}/lib/hdf5/plugin"
#make
#make check
#make install
#rm -rf $PREFIX/share/hdf5_examples
# ln -s $PREFIX/bin/gfortran $PREFIX/bin/f95
export CC=mpicc
./configure --prefix=$PREFIX --with-pthread=yes --with-zlib=$PREFIX --enable-parallel --enable-shared --with-default-plugindir="${PREFIX}/lib/hdf5/plugin"
make -j${CPU_COUNT}
make install

#rm -rf $PREFIX/share/hdf5_examples
