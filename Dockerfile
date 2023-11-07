# Start with a base image that includes CUDA, for example, the official CUDA 11.2 runtime Ubuntu image
FROM nvidia/cuda:12.2.2-cudnn8-devel-ubuntu22.04

# Set a label to describe the Dockerfile
LABEL maintainer="eanthony"

# Install Python 3.10 and pip
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.10 python3.10-distutils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/bin/python3.10 /usr/local/bin/python3 && \
    ln -s /usr/bin/python3.10 /usr/local/bin/python && \
    wget https://bootstrap.pypa.io/get-pip.py && \
    python3.10 get-pip.py && \
    rm get-pip.py && \
    apt-get git

RUN git clone https://github.com/Stability-AI/stablediffusion.git

RUN curl -L 'https://huggingface.co/stabilityai/stable-diffusion-2-1/resolve/main/v2-1_768-ema-pruned.ckpt' -o SD2.1-pruned.ckpt

# Copy your requirements.txt file into the container
COPY requirements.txt /stablediffusion/requirements.txt

# Install Python dependencies from the requirements file
RUN pip install --no-cache-dir -r /stablediffusion/requirements.txt

# Set the default command to run when starting the container
CMD [ "/bin/bash" ]
