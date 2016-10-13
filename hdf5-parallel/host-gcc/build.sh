#!/bin/bash

# ln -s $PREFIX/bin/gfortran $PREFIX/bin/f95

if [ "$(uname)" == "Darwin" ]
then
    
    export CXX=mpicxx
    export MACOSX_VERSION_MIN=10.9
    export CXXFLAGS="-mmacosx-version-min=${MACOSX_VERSION_MIN} -std=c++11 -stdlib=libc++ ${CXXFLAGS}"
    export LDFLAGS="-Wl,-rpath,$PREFIX/lib"
fi
export CC=mpicc
./configure --prefix=$PREFIX --enable-linux-lfs --with-zlib=$PREFIX --with-ssl --enable-parallel --enable-shared
make -j${CPU_COUNT}
make install

rm -rf $PREFIX/share/hdf5_examples
