#!/bin/bash

if [ "${CONDA_BUILD_TYPE}" = "host-gcc" ]; then
    # Dependencies
    conda build subprocess32/host-gcc
    conda build eigen3/host-gcc
    conda build boost/host-gcc
    conda build hdf5-parallel/host-gcc
    conda build h5py-parallel/host-gcc
    conda build vtk/host-gcc
    conda build petsc/host-gcc
    conda build petsc4py/host-gcc
    conda build slepc/host-gcc

elif [ "${CONDA_BUILD_TYPE}" = "conda-gcc" ]; then
    # Cannot seem to build VTK with conda gcc
    conda build hdf5-parallel/conda-gcc
    conda build h5py-parallel/conda-gcc
    conda build petsc/conda-gcc
    conda build petsc4py/conda-gcc
    conda build slepc/conda-gcc

elif [ "${CONDA_BUILD_TYPE}" = "osx-gcc" ]; then

    conda config --add channels conda-forge
    #conda build hdf5-parallel/osx-host
    #conda build h5py-parallel/osx-host
    conda build petsc/osx-host
    conda build petsc4py/osx-host
    conda build slepc/osx-host
    conda build slepc4py/osx-host
    #conda build vtk/osx-host

else

	echo "Configure build_fenics.conf and source it before executing this"

fi
