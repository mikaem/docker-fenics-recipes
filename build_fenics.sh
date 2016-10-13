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
#    conda build instant/host-gcc
#    conda build dijitso/host-gcc
#    conda build ufl/host-gcc
#    conda build fiat/host-gcc
#    conda build ffc/host-gcc
#    conda build dolfin/host-gcc
#    conda build dolfin-vtk/host-gcc
    conda build fenics
#    conda build fenics-vtk

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
