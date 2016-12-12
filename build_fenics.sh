#!/bin/bash

if [ ${FENICS_VERSION: -3} = dev ]; then
  declare -x GIT_TAG_DOLFIN=master

else
  declare -x GIT_TAG_DOLFIN=DOLFIN-${FENICS_GIT_TAG}
fi

if [ ${CONDA_BUILD_TYPE} = host-gcc ]; then
    conda build cf-fenics/host-gcc

elif [ ${CONDA_BUILD_TYPE} = conda-gcc ]; then
    conda build cf-fenics/conda-gcc

else
    conda build cf-fenics/osx-host

fi

