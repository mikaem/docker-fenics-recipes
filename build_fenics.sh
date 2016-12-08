#!/bin/bash

if [ ${FENICS_VERSION: -3} = dev ]; then
  declare -x GIT_TAG_DOLFIN=master

else
  declare -x GIT_TAG_DOLFIN=DOLFIN-${FENICS_GIT_TAG}
fi

conda build cf-fenics

