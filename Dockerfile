FROM nvidia/cuda:11.8.0-runtime-ubuntu22.04

WORKDIR /app
COPY . .

RUN apt-get update && \
    apt-get install --no-install-recommends -y wget git vim build-essential python3-dev python3-venv && \
    rm -rf /var/lib/apt/lists/*

RUN python3 -m venv /app/venv
RUN . /app/venv/bin/activate && \
    pip3 install --upgrade pip setuptools && \
    pip3 install torch torchvision torchaudio && \
    pip3 install -r requirements.txt
	
# https://developer.nvidia.com/cuda-gpus
# for a rtx 2060: ARG TORCH_CUDA_ARCH_LIST="7.5"
ARG TORCH_CUDA_ARCH_LIST="3.5;5.0;6.0;6.1;7.0;7.5;8.0;8.6+PTX"

EXPOSE 7860

CMD . /app/venv/bin/activate && python3 app.py