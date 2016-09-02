#!/bin/bash

source /home/${CONDA_USERNAME}/fenics-recipes/build_fenics.conf

# Dependencies
cd ../conda-recipes
conda build boost
conda build vtk
cd ../fenics-recipes
conda build hdf5-parallel
conda build h5py-parallel
conda build eigen3
#conda build hwloc
conda build petsc
conda build petsc4py
conda build slepc
