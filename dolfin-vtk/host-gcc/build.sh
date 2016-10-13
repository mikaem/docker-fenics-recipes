#!/bin/bash

rm -rf build
mkdir build
cd build

CC=mpicc
CXX=mpic++

export LIBRARY_PATH=$PREFIX/lib
export INCLUDE_PATH=$PREFIX/include
export HDF5_DIR=$PREFIX
export PETSC_DIR=$PREFIX
export PETSC_ARCH=arch-conda-c-opt
export PETSC_VERSION=3.7.3
export PARMETIS_DIR=$PREFIX/lib
export METIS_DIR=$PREFIX/lib
export UMFPACK_DIR=$PREFIX/lib
export BLAS_DIR=$PREFIX/lib
export LAPACK_DIR=$PREFIX/lib
export MACOSX_DEPLOYMENT_TARGET=10.9
#export MACOSX_DEPLOYMENT_TARGET=$(sw_vers -productVersion | sed -E "s/([0-9]+\.[0-9]+).*/\1/")

MACOSX_VERSION_MIN=10.9
export CXXFLAGS="-stdlib=libc++ -mmacosx-version-min=${MACOSX_VERSION_MIN}"
export LDFLAGS="-mmacosx-version-min=${MACOSX_VERSION_MIN} -stdlib=libc++ -Wl,-rpath,$PREFIX/lib"

# To make dolfin pick up anaconda swig:
#ln -s ${PREFIX}/bin/swig ${PREFIX}/bin/swig3.0

cmake .. \
  -DDOLFIN_ENABLE_VTK:BOOL=TRUE \
  -DDOLFIN_ENABLE_QT:BOOL=FALSE \
  -DDOLFIN_ENABLE_SCOTCH:BOOL=FALSE \
  -DDOLFIN_ENABLE_PASTIX:BOOL=FALSE \
  -DDOLFIN_ENABLE_TRILINOS:BOOL=FALSE \
  -DDOLFIN_ENABLE_PARMETIS:BOOL=TRUE \
  -DDOLFIN_ENABLE_SLEPC4PY:BOOL=FALSE \
  -DDOLFIN_ENABLE_UNIT_TESTS:BOOL=FALSE \
  -DDOLFIN_ENABLE_HDF5:BOOL=TRUE \
  -DDOLFIN_SKIP_BUILD_TESTS:BOOL=TRUE \
  -DHDF5_C_COMPILER_EXECUTABLE=$PREFIX/bin/h5pcc \
  -DHDF5_CXX_COMPILER_EXECUTABLE=$PREFIX/bin/h5pcc \
  -DCMAKE_C_COMPILER=$CC \
  -DCMAKE_CXX_COMPILER=$CXX \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_INCLUDE_PATH=$INCLUDE_PATH \
  -DCMAKE_LIBRARY_PATH=$LIBRARY_PATH \
  -DBoost_INCLUDE_DIR=$INCLUDE_PATH \
  -DBoost_LIBRARY_DIRS=$LIBRARY_PATH \
  -DBoost_FILESYSTEM_LIBRARY=$LIBRARY_PATH/libboost_filesystem.dylib \
  -DMPI_C_LIBRARIES=$LIBRARY_PATH/libmpich.dylib \
  -DMPI_C_INCLUDE_PATH=$INCLUDE_PATH \
  -DMPI_CXX_LIBRARIES=$LIBRARY_PATH/libmpichcxx.dylib \
  -DMPI_CXX_INCLUDE_PATH=$INCLUDE_PATH

make -j${CPU_COUNT}
make install
