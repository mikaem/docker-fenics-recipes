# docker-fenics-recipes
Conda recipes for building Fenics using Docker images as base

Description
----------

This repository contains recipes for building FEniCS for [Anaconda](https://anaconda.org) using [Docker](https://www.docker.com), starting from pure [Anaconda docker images](https://hub.docker.com/r/continuumio/). You may choose to compile FEniCS using conda's gcc, or a host gcc on the image. 

Note that if you do not want to use Docker, then the recipes can also be used to build FEniCS on your own computer directly. In that case it is reccommended to use the host gcc version of the scripts (set CONDA_BUILD_TYPE to host-gcc).

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

    git clone https://github.com/mikaem/docker-fenics-recipes.git
    cd docker-fenics-recipes 
    ... Modify variables
    docker build --tag docker-mybuild:latest .
  
This creates an image called `docker-mybuild` with all dependencies installed. To build FEniCS enter the image itself and build:

    docker run -ti docker-mybuild:latest /bin/bash
    cd /home/${CONDA_USERNAME}/docker-fenics-recipes  #(use your actual username from build_fenics.conf)
    source build_fenics.conf
    ./build_fenics.sh

This creates a docker container with FEniCS installed. Furthermore, all packages built will be uploaded to Anaconda cloud. This is why you need to set the correct CONDA_USERNAME in the build_fenics.conf file.

If you want to create a final Docker image after building FEniCS, you should commit the changes.

    docker commit -m 'Conda image with fenics installed' -a 'Mikael' 4401d51 docker-fenics:latest
    
 Here you need to get the correct container ID instead of 4401d51. Just check the previous line in the terminal to see the hash of the container.
 
 To build without Docker, set parameters in `build.fenics.conf`, source it, and then run `build_fenics_deps.sh` and `build_fenics.sh` in that order.
 
