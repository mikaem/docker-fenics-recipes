#!/bin/bash

export SLEPC_DIR=$SRC_DIR
export PETSC_DIR=$PREFIX

./configure --prefix=$PREFIX 
make
make install

