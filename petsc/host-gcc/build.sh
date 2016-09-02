#!/bin/bash

export LIBRARY_PATH=$PREFIX/lib

./configure \
  --prefix=$PREFIX \
  --with-mpi-dir=$PREFIX \
  --download-fblaslapack \
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
