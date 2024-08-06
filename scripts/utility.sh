#!/bin/bash

# Utility functions

export HOME=$(pwd)
export CPATH=/usr/local/cuda/targets/x86_64-linux/include:$CPATH
export LD_LIBRARY_PATH=/usr/local/cuda/targets/x86_64-linux/lib:$LD_LIBRARY_PATH
export PATH=/usr/local/cuda/bin:$PATH



log() {
    echo "[CONDOR SCRIPT LOG $(date '+%Y-%m-%d %H:%M:%S')] $1" | tee /dev/stderr
}

retry_command() {
    local command="$1"
    local max_retries="$2"
    local retry_count=0

    while [ $retry_count -lt $max_retries ]; do
        eval $command

        if [ $? -eq 0 ]; then
            echo "Command $command succeeded."
            return 0
        else
            echo "Command failed. Retrying... ($((retry_count + 1))/$max_retries)"
            retry_count=$((retry_count + 1))
            sleep 1  # Optional: wait for 1 second before retrying
        fi
    done
    echo "Command failed after $max_retries attempts."
    return 1
}