#!/bin/bash

# Update system
sudo apt update && sudo apt upgrade -y

# Install base tools
sudo apt install -y build-essential python3 python3-venv python3-pip curl git

# Install NVIDIA driver (L4 works with recent CUDA)
sudo apt install -y nvidia-driver-535

# Reboot might be needed
# sudo reboot

# Verify
nvidia-smi

# Install CUDA Toolkit if needed (optional)
# wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda_11.8.0_520.61.05_linux.run
# sudo sh cuda_11.8.0_520.61.05_linux.run

# Setup Python venv for OpenLLM
python3 -m venv openllm-venv
source openllm-venv/bin/activate
pip install --upgrade pip
pip install bentoml openllm[cli] openllm[servers] openllm[llms]

# Verify OpenLLM CLI
openllm -h
