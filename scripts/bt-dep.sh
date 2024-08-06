#!/bin/bash

git clone https://github.com/huggingface/alignment-handbook.git
cd ./alignment-handbook/

# Updated commit
# git checkout 606d2e954fd17999af40e6fb4f712055ca11b2f0
pip install "numpy<2.0.0"
# The test cuda version is 12.1, 12.2. You may need to update the torch version based on your cuda version...
pip install torch==2.1.2 torchvision torchaudio
python -m pip install .
cd ..

pip install flash-attn
# pip install accelerate==0.27.2
## You may need to modify the version of transformers for the model you want to use...
pip install transformers==4.43.4

pip install mpi4py
conda install nvidia/label/cuda-12.2.0::cuda-nvcc

#################################################

