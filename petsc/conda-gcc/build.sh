#!/bin/bash

export LIBRARY_PATH=$PREFIX/lib

export PETSC_DIR=$SRC_DIR
export PETSC_ARCH=arch-conda-c-opt

if [[ $(uname) == Darwin ]]; then
    SO=dylib
else
    SO=so
fi

./configure LDFLAGS="-Wl,-rpath,$PREFIX/lib" \
  --prefix=$PREFIX \
  --with-blas-lapack-lib=libopenblas.$SO \
  --with-mpi-dir=$PREFIX \
  --with-hwloc=0 \
  --download-metis \
  --download-parmetis \
  --download-hypre \
  --download-scalapack \
  --download-mumps \
  --download-superlu_dist \
  --download-suitesparse \
  --with-shared-libraries

make
make install

