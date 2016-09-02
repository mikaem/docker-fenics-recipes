#!/bin/bash

export CC=mpicc
$PYTHON setup.py configure --mpi --hdf5=$PREFIX
$PYTHON setup.py build_ext
$PYTHON setup.py install
