#!/bin/bash

# export CC=$PREFIX/bin/gcc
# export CXX=$PREFIX/bin/g++

$PYTHON setup.py install --prefix=$PREFIX --single-version-externally-managed --record=/tmp/record.txt

# Add more build steps here, if they are necessary.

# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.
