#!/bin/bash

if [[ "$(uname)" == "Darwin" ]]; then
  export MACOSX_DEPLOYMENT_TARGET=10.9
  export CXXFLAGS="-std=c++11 -stdlib=libc++ $CXXFLAGS"
  export LDFLAGS="-Wl,-rpath,$PREFIX/lib $LDFLAGS"
fi

# Components (ffc, etc.)
for mod in INSTANT DIJITSO UFL FIAT FFC DOLFIN
do
  if [[ ${FENICS_VERSION: -3} = "dev" ]]; then
    declare -x GIT_TAG_${mod}=master

  else
    low=$(echo ${mod} | tr "[:upper:]" "[:lower:]")
    declare -x GIT_TAG_${mod}=${low}-${FENICS_GIT_TAG}
  fi

done

echo ${RECIPE_DIR}
pip install --no-deps --no-binary :all: -r "${RECIPE_DIR}/component-requirements.txt"

# DOLFIN

# tarball includes cached swig output built with Python 2.
# Regenerate with correct Python
$PYTHON cmake/scripts/generate-swig-interface.py

rm -rf build
mkdir build
cd build

export LIBRARY_PATH=$PREFIX/lib
export INCLUDE_PATH=$PREFIX/include

export PETSC_DIR=$PREFIX
export SLEPC_DIR=$PREFIX
export BLAS_DIR=$LIBRARY_PATH

cmake .. \
  -DDOLFIN_ENABLE_OPENMP=off \
  -DDOLFIN_ENABLE_MPI=on \
  -DDOLFIN_ENABLE_PETSC=on \
  -DDOLFIN_ENABLE_PETSC4PY=on \
  -DDOLFIN_ENABLE_SLEPC=on \
  -DDOLFIN_ENABLE_SCOTCH=on \
  -DDOLFIN_ENABLE_PARMETIS=on \
  -DDOLFIN_ENABLE_HDF5=on \
  -DDOLFIN_ENABLE_VTK=off \
  -DDOLFIN_USE_PYTHON3=off \
  -DDOLFIN_SKIP_BUILD_TESTS=off \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_INCLUDE_PATH=$INCLUDE_PATH \
  -DCMAKE_LIBRARY_PATH=$LIBRARY_PATH \
  -DPYTHON_EXECUTABLE=$PYTHON || (cat CMakeFiles/CMakeError.log && exit 1)

make VERBOSE=1 -j$CPU_COUNT
make install

# remove paths for unused deps in cmake files
# these paths may not exist on targets and aren't needed,
# but cmake will die with 'no rule to make /Applications/...libclang_rt.osx.a'

if [[ "$(uname)" == "Darwin" ]]; then
    find $PREFIX/share/dolfin -name '*.cmake' -print -exec sh -c "sed -E -i ''  's@/Applications/Xcode.app[^;]*(.dylib|.framework|.a);@@g' {}" \;
else
    find $PREFIX/share/dolfin -name '*.cmake' -print -exec sh -c "sed -E -i''  's@/usr/lib(64)?/[^;]*(.so|.a);@@g' {}" \;
fi


