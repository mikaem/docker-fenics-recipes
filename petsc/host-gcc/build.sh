#!/bin/bash

export LIBRARY_PATH=$PREFIX/lib

export PETSC_DIR=$SRC_DIR
export PETSC_ARCH=arch-conda-c-opt
export MACOSX_DEPLOYMENT_TARGET=$(sw_vers -productVersion | sed -E "s/([0-9]+\.[0-9]+).*/\1/")

./configure MACOSX-DEPLOYMENT-TARGET=${MACOSX_DEPLOYMENT_TARGET} \
  --prefix=$PREFIX \
  --LDFLAGS=-Wl,-rpath,$PREFIX/lib \
  --with-fc=0 \
  --with-x=0 \
  --with-mpi-dir=$PREFIX \
  --with-blas-lapack-lib=libopenblas.so \
  --download-hypre \
  --download-metis \
  --download-parmetis \
  --download-suitesparse \
  --with-shared-libraries

make
make install


sedinplace() { [[ $(uname) == Darwin ]] && sed -i "" $@ || sed -i"" $@; }
for path in ${PETSC_DIR} ${PREFIX}; do
    sedinplace s%$path%\${PETSC_DIR}%g $PETSC_ARCH/include/petsc*.h
done

install_name_tool -change libmetis.dylib ${PREFIX}/lib/libmetis.dylib ${PREFIX}/lib/libpetsc.dylib
install_name_tool -change libparmetis.dylib ${PREFIX}/lib/libparmetis.dylib ${PREFIX}/lib/libpetsc.dylib
