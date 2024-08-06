#!/bin/bash

set -e

. scripts/utility.sh
. scripts/infra.sh

###########################################################################

conda create -n rm_dev python=3.10.9
conda activate rm_dev

. scripts/bt-dep.sh

. scripts/login.sh

#################################################

git clone https://github.com/yurun-yuan/RLHF-Reward-Modeling.git

# cd RLHF-Reward-Modeling

# log "Start training"

# export MODEL_OUTPUT_PATH=$(pwd)/models/llama3_rm_test
# mkdir -p $MODEL_OUTPUT_PATH

# export TORCHELASTIC_ERROR_FILE=$HOME/
# mkdir -p $TORCHELASTIC_ERROR_FILE

# # export TORCH_USE_CUDA_DSA
# # export CUDA_LAUNCH_BLOCKING=1 

# accelerate launch \
#     --num_machines 1 \
#     --num_processes 3 \
#     --machine_rank 0 \
#     --main_process_ip $(hostname -I | awk '{print $1}') \
#     --main_process_port 12956 \
#     --mixed_precision bf16 ./bradley-terry-rm/llama3_rm.py \
#     --model_name meta-llama/Meta-Llama-3.1-8B-Instruct \
#     --local_model_path /staging/yyuan244/llama31_pretrain\
#     --max_length 4096 \
#     --train_set_path RyanYr/preference_700K_llama31_tokenized \
#     --output_path $MODEL_OUTPUT_PATH \
#     --bf16 True \
#     --save_every_steps 100 \
#     --gradient_accumulation_steps 256 # \
#     # --deepspeed ./deepspeed_configs/deepspeed_3.json

# cd ..

# log "Done training"

# log "Start copying to staging folder"

# tar -czvf /staging/yyuan244/bt-rm-llama31.tar.gz $MODEL_OUTPUT_PATH || true

# log "Copied to staging folder"

#################################################

conda deactivate

#################################################

# . scripts/commit.sh

set +e
