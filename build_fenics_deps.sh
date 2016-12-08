#!/bin/bash

if [ ${CONDA_BUILD_TYPE} = host-gcc ]; then
    # Dependencies
    conda build hdf5-parallel/host-gcc
    conda build h5py-parallel/host-gcc
    conda build vtk/host-gcc
else
    # Dependencies
    #conda build hdf5-parallel/conda-gcc
    #conda build h5py-parallel/conda-gcc
    conda build vtk/conda-gcc
fi

