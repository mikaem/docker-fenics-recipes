# docker-fenics-recipes
Conda recipes for building Fenics using Docker images as base

Description
----------

This repository contains recipes for building FEniCS for [Anaconda](https://anaconda.org) using [Docker](https://www.docker.com), starting from pure [Anaconda docker images](https://hub.docker.com/r/continuumio/). You may choose to compile FEniCS using conda's gcc, or a host gcc on the image. 

FEniCS built with conda gcc can be used by continuous integration tools like TravisCI and CircleCI.

The script `build_fenics.conf` contains the following environment variables

  * CONDA_BUILD_TYPE         =host-gcc  (alternatively conda-gcc)
  * CONDA_USERNAME           =mikaem      (A username on Anaconda cloud)
  * CONDA_BUILD_NUMBER       =12       
  * CONDA_BUILD_LABEL        =docker-hostgcc  (Becomes the label on Anaconda Cloud)
  * CONDA_BUILD_DIR          =/opt/conda/conda-bld/linux-64
  * FENICS_VERSION           =2016.2.dev  (2016.2.dev is current master. 2016.1 becomes stable build of 2016.1 tag)
  * FENICS_GIT_TAG           =2016.1.0    (If stable build is chosen, then the tag may be set here)

Build all dependencies in Docker using, e.g.,

  git clone 
  docker build --tag docker-mybuild:latest .
  
This creates an image with all dependencies installed. To build FEniCS enter the image and build:

  docker run -ti docker-mybuild:latest /bin/bash
  cd /home/${CONDA_USERNAME}/docker-fenics-recipes
  source build_fenics.conf
  ./build_fenics.sh

This creates a docker container with FEniCS installed. Furthermore, all packages built will be uploaded to Anaconda cloud. This is why you need to set the correct CONDA_USERNAME in the build_fenics.conf file.

