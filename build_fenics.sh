#!/bin/bash

for mod in INSTANT DIJITSO UFL FIAT FFC DOLFIN 
do
  if [ ${FENICS_VERSION: -3} = dev ]; then
    declare -x GIT_TAG_${mod}=master

  else
    declare -x GIT_TAG_${mod}=${mod,,}-${FENICS_GIT_TAG}
  fi
done

if [ ${CONDA_BUILD_TYPE} = host-gcc ]; then
    conda build instant/host-gcc
    conda build dijitso/host-gcc
    conda build ufl/host-gcc
    conda build fiat/host-gcc
    conda build ffc/host-gcc
    conda build dolfin/host-gcc
#     conda build dolfin-vtk/host-gcc
    conda build fenics
#     conda build fenics-vtk

else
    conda build instant/conda-gcc
    conda build dijitso/conda-gcc
    conda build ufl/conda-gcc
    conda build fiat/conda-gcc
    conda build ffc/conda-gcc
    conda build dolfin/conda-gcc
#     conda build dolfin-vtk/conda-gcc
    conda build fenics
#     conda build fenics-vtk

fi

conda config --add channels ${CONDA_USERNAME}/label/${CONDA_BUILD_LABEL}

# Upload all dependencies if not already there
anaconda upload ${CONDA_BUILD_DIR}/boost-1.60.0-py27_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
anaconda upload ${CONDA_BUILD_DIR}/vtk-5.10.1-${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
anaconda upload ${CONDA_BUILD_DIR}/hdf5-parallel-1.8.14-${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
anaconda upload ${CONDA_BUILD_DIR}/h5py-parallel-2.6.0-py27_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
anaconda upload ${CONDA_BUILD_DIR}/eigen3-3.2.1-${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
anaconda upload ${CONDA_BUILD_DIR}/hwloc-1.11.2-${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
anaconda upload ${CONDA_BUILD_DIR}/petsc-3.7.3-py27_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
anaconda upload ${CONDA_BUILD_DIR}/petsc4py-3.7.0-py27_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
anaconda upload ${CONDA_BUILD_DIR}/slepc-3.7.2-py27_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}

anaconda upload ${CONDA_BUILD_DIR}/instant-${FENICS_VERSION}-py27_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
anaconda upload ${CONDA_BUILD_DIR}/dijitso-${FENICS_VERSION}-py27_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
anaconda upload ${CONDA_BUILD_DIR}/ufl-${FENICS_VERSION}-py27_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
anaconda upload ${CONDA_BUILD_DIR}/fiat-${FENICS_VERSION}-py27_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
anaconda upload ${CONDA_BUILD_DIR}/ffc-${FENICS_VERSION}-py27_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
anaconda upload ${CONDA_BUILD_DIR}/dolfin-${FENICS_VERSION}-py27_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
anaconda upload ${CONDA_BUILD_DIR}/dolfin-${FENICS_VERSION}-py27_vtk_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
anaconda upload ${CONDA_BUILD_DIR}/fenics-${FENICS_VERSION}-${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
anaconda upload ${CONDA_BUILD_DIR}/fenics-${FENICS_VERSION}-vtk_${CONDA_BUILD_NUMBER}.tar.bz2 --label ${CONDA_BUILD_LABEL}
