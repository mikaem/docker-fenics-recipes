# docker-fenics-recipes
Conda recipes for building Fenics using Docker images as base.

Description
----------

This repository contains recipes for building FEniCS for [Anaconda](https://anaconda.org) using [Docker](https://www.docker.com), starting from pure [Anaconda docker images](https://hub.docker.com/r/continuumio/). You may choose to compile FEniCS using conda's gcc, or a host gcc on the image. 

Note that if you do not want to use Docker, then the recipes can also be used to build FEniCS on your own computer directly. In that case it is reccommended to use the host gcc version of the scripts (set CONDA_BUILD_TYPE to host-gcc).

Continuous Integration with Travis CI or CircleCI
----------------------

FEniCS built with conda gcc can be used to test your FEniCS application through continuous integration tools like TravisCI and CircleCI. For Travis you can include FEniCS in the `.travis.yml` file as:

    language: python
    
    python:
        - "2.7"
    
    sudo: false
    
    install:
        - wget https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh -O miniconda.sh;
        - bash miniconda.sh -b -p $HOME/miniconda
        - export PATH="$HOME/miniconda/bin:$PATH"
        - unset PYTHONPATH
        - conda config --set always_yes yes 
        - conda config --add channels mikaem/label/docker-conda-gcc
        - conda install fenics=2016.2.dev
 
Change to `conda install fenics=2016.1` for a stable FEniCS 2016.1 installation. Note the line with `sudo: false`. This allows Travis to use a container-based infrastructure that ensures your build will start in seconds.

A similar example of setting up a `circle.yml` file to use FEniCS for continuous integration with CircleCI is:

    machine:
    environment:
        CONDA_ROOT: /home/ubuntu/miniconda
        PATH: ${CONDA_ROOT}/bin:${PATH}

    dependencies:
    cache_directories:
        - /home/ubuntu/miniconda

    override:
        - >
        if [[ ! -d ${CONDA_ROOT} ]]; then
            echo "Installing Miniconda...";
            wget --quiet https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh &&
            bash Miniconda-latest-Linux-x86_64.sh -b -p ${CONDA_ROOT};
        else
            echo "Using cached Miniconda install";
        fi
        - conda config --set always_yes yes
        - conda update -q conda
        - conda info -a
        - conda config --add channels mikaem/label/docker-conda-gcc
        - conda install -y fenics=2016.2.dev

See [fenicstools](https://github.com/mikaem/fenicstools) for a live project that is using both Travis CI and CircleCI.

Usage of recipes
----
The script `build_fenics.conf` contains the following environment variables

  * CONDA_BUILD_TYPE         =host-gcc  (alternatively conda-gcc)
  * CONDA_USERNAME           =mikaem      (A username on Anaconda cloud)
  * CONDA_BUILD_NUMBER       =12       
  * CONDA_BUILD_LABEL        =docker-host-gcc  (Becomes the label on Anaconda Cloud)
  * CONDA_BUILD_DIR          =/opt/conda/conda-bld/linux-64
  * FENICS_VERSION           =2016.2.dev  (2016.2.dev is current master. 2016.1 becomes stable build of 2016.1 tag)
  * FENICS_GIT_TAG           =2016.1.0    (If stable build is chosen, then the tag may be set here)

Build all dependencies in Docker using, e.g.,

    git clone https://github.com/mikaem/docker-fenics-recipes.git
    cd docker-fenics-recipes 
    ... Modify variables in build_fenics.conf
    cp Dockerfiles.conda-gcc Dockerfiles     # Alternatively cp Dockerfiles.host-gcc Dockerfiles
    docker build --tag docker-mybuild:latest .

This creates an image called `docker-mybuild` with all dependencies installed. To build FEniCS enter the image itself and build:

    docker run -ti docker-mybuild:latest /bin/bash
    cd /home/${CONDA_USERNAME}/docker-fenics-recipes  #(use your actual username from build_fenics.conf)
    git pull  #(To get any changes to rep since image was made)
    source build_fenics.conf
    ./build_fenics.sh
    ./anaconda_upload.sh

This creates a docker container with FEniCS installed as well as Anaconda. Furthermore, through `anaconda_upload.sh` all packages built will be uploaded to Anaconda cloud, which is why you need to set the correct CONDA_USERNAME in the build_fenics.conf file. For uploading you will be prompted for a password to anaconda cloud.

If you want to create a final Docker image after building FEniCS, you should commit the changes after exiting the container.

    exit  # exit docker container
    docker commit -m 'Conda image with fenics installed' -a 'Mikael' 4401d51 docker-fenics:latest
    
 Here you need to get the correct container ID instead of 4401d51. Just check the line in the terminal before you exit to see the hash of the container.
 
 To build without Docker, set parameters in `build.fenics.conf`, source it, and then run `build_fenics_deps.sh` and `build_fenics.sh` in that order.
 
