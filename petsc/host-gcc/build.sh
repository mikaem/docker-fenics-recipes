#!/bin/bash

export LIBRARY_PATH=$PREFIX/lib

export PETSC_DIR=$SRC_DIR
#export PETSC_ARCH=arch-conda-c-opt

if [[ $(uname) == Darwin ]]; then
    SO=dylib
else
    SO=so
fi

./configure \
  --prefix=$PREFIX \
  --with-mpi-dir=$PREFIX \
  --with-blas-lapack-lib=libopenblas.$SO \
  --download-metis \
  --download-parmetis \
  --download-hypre \
  --download-mumps \
  --download-scalapack \
  --download-superlu_dist \
  --download-suitesparse \
  --with-shared-libraries

make
make install
