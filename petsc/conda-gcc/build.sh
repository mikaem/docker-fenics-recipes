#!/bin/bash

export LIBRARY_PATH=$PREFIX/lib

./configure LDFLAGS="-Wl,-rpath,$PREFIX/lib" \
  --prefix=$PREFIX \
  --with-blas-lapack-lib=libopenblas.dylib \
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

# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.
