#!/bin/bash

conda create --name fenics-${CONDA_BUILD_NUMBER} boost=1.61 eigen 
source activate fenics-${CONDA_BUILD_NUMBER}

# Dependencies
conda build hdf5-parallel/host-gcc
conda build h5py-parallel/host-gcc
conda build vtk/host-gcc
conda build petsc/host-gcc
conda build petsc4py/host-gcc
conda build slepc/host-gcc


