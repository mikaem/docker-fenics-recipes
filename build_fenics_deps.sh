#!/bin/bash

if [ ${CONDA_BUILD_TYPE} = host-gcc ]; then
    # Dependencies
    conda build boost/host-gcc
    conda build vtk/host-gcc
    conda build hdf5-parallel/host-gcc
    conda build h5py-parallel/host-gcc
    conda build eigen3/host-gcc
    conda build petsc/host-gcc
    conda build petsc4py/host-gcc
    conda build slepc/host-gcc

else
    # Dependencies
    conda build boost/conda-gcc
#     conda build vtk/conda-gcc
    conda build hdf5-parallel/conda-gcc
    conda build h5py-parallel/conda-gcc
    conda build eigen3/conda-gcc
    conda build petsc/conda-gcc
    conda build petsc4py/conda-gcc
    conda build slepc/conda-gcc
fi