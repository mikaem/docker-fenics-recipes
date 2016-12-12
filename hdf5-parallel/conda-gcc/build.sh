#!/bin/bash

# ln -s $PREFIX/bin/gfortran $PREFIX/bin/f95
export CC=mpicc
export CFLAGS="-w"
./configure --prefix=$PREFIX --enable-linux-lfs --with-default-api-version=v18 --enable-unsupported --enable-production=yes --with-pthread --with-zlib=$PREFIX --enable-parallel --enable-shared
make -j${CPU_COUNT}
make install

rm -rf $PREFIX/share/hdf5_examples
