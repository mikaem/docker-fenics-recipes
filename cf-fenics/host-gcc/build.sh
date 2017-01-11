#!/bin/bash

if [[ "$(uname)" == "Darwin" ]]; then
  export MACOSX_DEPLOYMENT_TARGET=10.9
  MACOSX_VERSION_MIN=10.9
  export CXXFLAGS="-stdlib=libc++ -mmacosx-version-min=${MACOSX_VERSION_MIN}"
  export LDFLAGS="-stdlib=libc++ -mmacosx-version-min=${MACOSX_VERSION_MIN}  -Wl,-rpath,$PREFIX/lib"
fi

# Components (ffc, etc.)
pip install --no-deps --no-binary :all: -r "${RECIPE_DIR}/component-requirements.txt"

# DOLFIN

# tarball includes cached swig output built with Python 2.
# Remove it because it breaks building on Python 3.
rm -rf dolfin/swig/modules

CC=mpicc
CXX=mpic++

rm -rf build
mkdir build
cd build

export LIBRARY_PATH=$PREFIX/lib
export INCLUDE_PATH=$PREFIX/include

export PETSC_DIR=$PREFIX
#export PETSC_ARCH=arch-conda-c-opt
export PETSC_VERSION=3.7.3
export PARMETIS_DIR=$PREFIX/lib
export METIS_DIR=$PREFIX/lib
export UMFPACK_DIR=$PREFIX/lib
export SLEPC_DIR=$PREFIX
export BLAS_DIR=$LIBRARY_PATH
export SCOTCH_DIR=$PREFIX

cmake .. \
  -DDOLFIN_ENABLE_OPENMP=off \
  -DDOLFIN_ENABLE_MPI=on \
  -DDOLFIN_ENABLE_PETSC=on \
  -DDOLFIN_ENABLE_PETSC4PY=on \
  -DDOLFIN_ENABLE_SCOTCH=on \
  -DDOLFIN_ENABLE_HDF5=on \
  -DDOLFIN_ENABLE_VTK=on \
  -DCMAKE_C_COMPILER=$CC \
  -DCMAKE_CXX_COMPILER=$CXX \
  -DCMAKE_EXE_LINKER_FLAGS=-Wl,-rpath,$PREFIX/lib \
  -DBLAS_LIBRARIES=$PREFIX/lib/libopenblas.so \
  -DCMAKE_MACOSX_RPATH=ON \
  -DDOLFIN_SKIP_BUILD_TESTS:BOOL=TRUE \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_INCLUDE_PATH=$INCLUDE_PATH \
  -DCMAKE_LIBRARY_PATH=$LIBRARY_PATH \
  -DPYTHON_EXECUTABLE=$PYTHON || (cat CMakeFiles/CMakeError.log && exit 1)

make VERBOSE=1 -j${CPU_COUNT}
make install

# remove paths for unused deps in cmake files
# these paths may not exist on targets and aren't needed,
# but cmake will die with 'no rule to make /Applications/...libclang_rt.osx.a'

if [[ "$(uname)" == "Darwin" ]]; then
    find $PREFIX/share/dolfin -name '*.cmake' -print -exec sh -c "sed -E -i ''  's@/Applications/Xcode.app[^;]*(.dylib|.framework|.a);@@g' {}" \;
else
    find $PREFIX/share/dolfin -name '*.cmake' -print -exec sh -c "sed -E -i''  's@/usr/lib(64)?/[^;]*(.so|.a);@@g' {}" \;
fi


