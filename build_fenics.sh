#!/bin/bash

for mod in INSTANT DIJITSO UFL FIAT FFC DOLFIN 
do
  if [[ ${FENICS_VERSION: -3} = "dev" ]]; then
    declare -x GIT_TAG_${mod}=master

  else
    low=$(echo ${mod} | tr "[:upper:]" "[:lower:]")
    declare -x GIT_TAG_${mod}=${low}-${FENICS_GIT_TAG}
  fi
done

if [ ${CONDA_BUILD_TYPE} = host-gcc ]; then
    conda build cf-fenics/host-gcc

elif [ ${CONDA_BUILD_TYPE} = conda-gcc ]; then
    conda build cf-fenics/conda-gcc

else
    conda build cf-fenics/osx-host

fi

