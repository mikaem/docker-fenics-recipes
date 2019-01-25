#!/bin/bash

if [[ $(uname) == Darwin ]]; then
    export LDFLAGS="-headerpad_max_install_names $LDFLAGS"
fi

export netCDF4_DIR=$PREFIX
export HDF5_DIR=$PREFIX
export CC=mpicc

${PYTHON} setup.py install --single-version-externally-managed --record record.txt
