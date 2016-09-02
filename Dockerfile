# image containing Fenics dependencies built with conda

FROM continuumio/anaconda:latest
USER root

COPY build_fenics.conf /root/build_fenics.conf

RUN export DEBIAN_FRONTEND=noninteractive && \
    conda config --set always_yes yes && \
    . ~/build_fenics.conf && \
    echo ${CONDA_USERNAME} && \
    mkdir /home/${CONDA_USERNAME} && \
    cd /home/${CONDA_USERNAME} && \
    apt-get -y install build-essential && \    
    git clone https://github.com/mikaem/conda-recipes.git && cd conda-recipes && git checkout host-gcc && cd .. && \
    git clone https://github.com/mikaem/fenics-recipes.git && cd fenics-recipes && git checkout host-gcc && \
    chmod a+x build_fenics_deps.sh && \
    #./build_fenics_deps.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \   
    conda clean --all && rm -rf /opt/conda/conda-bld/git-cache/*

WORKDIR /home/${CONDA_USERNAME}

USER root
