#!/bin/bash
export CC=mpicc
export HDF5_MPI="ON"
$PYTHON setup.py configure --mpi --hdf5=$PREFIX
$PYTHON setup.py build_ext
$PYTHON setup.py install
