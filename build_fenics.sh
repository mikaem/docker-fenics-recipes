# Using host gcc
# Make sure gfortran and cmake are installed on host.
# sudo apt install gfortran cmake

export CONDA_BUILD_DIR=/home/mikael/anaconda2/conda-bld/linux-64
export FENICS_VERSION=2016.2.dev
#!/bin/bash

source /home/${CONDA_USERNAME}/fenics-recipes/build_fenics.conf

# # Dependency for this branch only
# ## Need to install boost myself because of incompatible icu (see https://github.com/ContinuumIO/anaconda-issues/issues/700)
# cd ../conda-recipes
# ## conda build vtk
# ## anaconda upload --force ${CONDA_BUILD_DIR}/vtk-5.10.1-${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
# conda build boost
# anaconda upload --force ${CONDA_BUILD_DIR}/boost-1.60.0-py27_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
# # Other dependencies
# cd ../fenics-recipes
# conda build hdf5-parallel
# anaconda upload --force ${CONDA_BUILD_DIR}/hdf5-parallel-1.8.14-${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
# conda build h5py-parallel
# anaconda upload --force ${CONDA_BUILD_DIR}/h5py-parallel-2.6.0-py27_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
# # # conda build hwloc
# # # anaconda upload --force ${CONDA_BUILD_DIR}/hwloc-1.11.2-${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
# conda build eigen3
# anaconda upload --force ${CONDA_BUILD_DIR}/eigen3-3.2.1-${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
# conda build petsc
# anaconda upload --force ${CONDA_BUILD_DIR}/petsc-3.7.3-py27_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
# conda build petsc4py
# anaconda upload --force ${CONDA_BUILD_DIR}/petsc4py-3.7.0-py27_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
# conda build slepc
# anaconda upload --force ${CONDA_BUILD_DIR}/slepc-3.7.2-py27_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}

# conda build instant
# anaconda upload --force ${CONDA_BUILD_DIR}/instant-${FENICS_VERSION}-py27_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
# conda build dijitso
# anaconda upload --force ${CONDA_BUILD_DIR}/dijitso-${FENICS_VERSION}-py27_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
# conda build ufl
# anaconda upload --force ${CONDA_BUILD_DIR}/ufl-${FENICS_VERSION}-py27_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
# conda build fiat
# anaconda upload --force ${CONDA_BUILD_DIR}/fiat-${FENICS_VERSION}-py27_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
# conda build ffc
# anaconda upload --force ${CONDA_BUILD_DIR}/ffc-${FENICS_VERSION}-py27_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
# conda build dolfin
# anaconda upload --force ${CONDA_BUILD_DIR}/dolfin-${FENICS_VERSION}-py27_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
# conda build dolfin-vtk
# anaconda upload --force ${CONDA_BUILD_DIR}/dolfin-${FENICS_VERSION}-py27_vtk_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
# conda build fenics
# anaconda upload --force ${CONDA_BUILD_DIR}/fenics-${FENICS_VERSION}-${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
conda build fenics-vtk
anaconda upload --force ${CONDA_BUILD_DIR}/fenics-${FENICS_VERSION}-vtk_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
