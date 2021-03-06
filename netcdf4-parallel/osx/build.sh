#!/bin/bash

if [[ $(uname) == Darwin ]]; then
    export LDFLAGS="-headerpad_max_install_names $LDFLAGS"
    export MACOSX_DEPLOYMENT_TARGET=10.9
fi

export netCDF4_DIR=$PREFIX
export HDF5_DIR=$PREFIX
export CC=mpicc

${PYTHON} -m pip install . --no-deps --ignore-installed --no-cache-dir -vvv
