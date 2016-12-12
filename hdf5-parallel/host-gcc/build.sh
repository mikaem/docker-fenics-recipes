#!/bin/bash

# ln -s $PREFIX/bin/gfortran $PREFIX/bin/f95
export CFLAGS="-w"
CC=mpicc ./configure --prefix=$PREFIX --enable-linux-lfs --with-zlib=$PREFIX --enable-parallel --enable-shared
make -j${CPU_COUNT}
make install

rm -rf $PREFIX/share/hdf5_examples
