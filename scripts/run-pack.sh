#!/bin/bash

set -e

. scripts/utility.sh
. scripts/infra.sh

###########################################################################

mkdir -p rm
tar -xzvf /staging/yyuan244/bt-rm-conda-pack.tar.gz -C rm/
. rm/bin/activate
conda-unpack
pip install --upgrade transformers

conda install nvidia/label/cuda-12.2.0::cuda-nvcc
conda install nvidia::cuda-cudart-dev

ln -s /usr/local/cuda/lib64/libcurand.so $HOME/rm/lib/python3.10/site-packages/torch/lib

. scripts/login.sh

#################################################

git clone https://github.com/yurun-yuan/RLHF-Reward-Modeling.git

cd RLHF-Reward-Modeling

log "Start training"

export MODEL_OUTPUT_PATH=$(pwd)/models/llama3_rm_test
mkdir -p $MODEL_OUTPUT_PATH

# export TORCHELASTIC_ERROR_FILE=$HOME/
# mkdir -p $TORCHELASTIC_ERROR_FILE

# export TORCH_USE_CUDA_DSA
# export CUDA_LAUNCH_BLOCKING=1

# printenv

accelerate launch \
    --num_machines 1 \
    --num_processes 4 \
    --machine_rank 0 \
    --main_process_ip $(hostname -I | awk '{print $1}') \
    --main_process_port 12956 \
    --mixed_precision bf16 ./bradley-terry-rm/llama3_rm.py \
    --model_name meta-llama/Meta-Llama-3.1-8B-Instruct \
    --local_model_path /staging/yyuan244/llama31_pretrain\
    --per_device_train_batch_size 1 \
    --train_set_path RyanYr/preference_700K_llama31_tokenized \
    --output_path $MODEL_OUTPUT_PATH \
    --bf16 True \
    --save_every_steps 10 \
    --push_to_hub True \
    --hub_model_id RyanYr/bt-rm \
    --hub_token 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 \
    --save_total_limit 2 \
    --gradient_accumulation_steps 256 \
    --torch_random_seed 3407 \
    --max_length 4096 \
    --deepspeed ./deepspeed_configs/deepspeed_2.json

cd ..

log "Done training"

log "Start copying to staging folder"

tar -czvf /staging/yyuan244/bt-rm-llama31.tar.gz $MODEL_OUTPUT_PATH || true

log "Copied to staging folder"

# . scripts/commit.sh

conda deactivate

set +e
