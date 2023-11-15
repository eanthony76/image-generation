# image-generation

### Purpose
This repository contains the Dockerfile needed to containerize the AUTOMATIC1111 stable diffusion web UI

### Usage
Clone the git repository and run ```docker build -t stable-diffusion:latest .```
This will create for everything you need. After the image is built, run ```docker run --gpus all -p 7860:7860 stable-diffusion:latest``` to run the container and open up your web UI.
