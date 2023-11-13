# Start with a base image that includes CUDA, for example, the official CUDA 11.2 runtime Ubuntu image
FROM nvidia/cuda:12.2.2-cudnn8-devel-ubuntu22.04

# Set a label to describe the Dockerfile
LABEL maintainer="eanthony"

# Install Python 3.10 and pip
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    python3 \
    python3-venv \
    pip \
    libgl1 \
    libglib2.0-0 \
    && mkdir stable-diffusion \
    && cd stable-diffusion \
    && wget -q https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh \
    && useradd -m notroot

RUN pip3 install --upgrade pip
RUN pip install xformers==0.0.16

WORKDIR /stable-diffusion

RUN chmod +x webui.sh

EXPOSE 7860

RUN ./webui.sh -f

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]