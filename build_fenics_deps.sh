#!/bin/bash

if [ ${CONDA_BUILD_TYPE} = host-gcc ]; then
    # Dependencies
#     conda build hdf5-parallel/host-gcc
#     conda build h5py-parallel/host-gcc
#    conda build vtk/host-gcc
#     conda build petsc/host-gcc
#    conda build petsc4py/host-gcc
#     conda build slepc/host-gcc
#     conda build subprocess32/host-gcc
#     conda build eigen3/host-gcc
    conda build boost/host-gcc

else
    # Dependencies (Cannot build VTK with conda gcc)
    conda build hdf5-parallel/conda-gcc
    conda build h5py-parallel/conda-gcc
    conda build petsc/conda-gcc
fi

