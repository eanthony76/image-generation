# Start with a base image that includes CUDA, for example, the official CUDA 11.2 runtime Ubuntu image
FROM nvidia/cuda:12.2.2-cudnn8-devel-ubuntu22.04

# Set a label to describe the Dockerfile
LABEL maintainer="eanthony"

# Install Miniconda
ENV MINICONDA_VERSION 4.10.1
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH

# Install Miniconda in silent mode, install Python 3.8, and make sure the package is up to date
RUN apt-get update && apt-get install -y wget && \
    wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py38_${MINICONDA_VERSION}-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p $CONDA_DIR && \
    rm ~/miniconda.sh && \
    conda install -y python=3.10 && \
    conda clean -ya

# Set the default command to run when starting the container
CMD [ "/bin/bash" ]
