#!/bin/bash

# Infrastructure dependencies

# OpenMPI, For CHTC system
export PATH
. /etc/profile.d/modules.sh
module load OpenMPI/3.1.4-GCC-8.3.0

# Miniconda
. scripts/conda_setup.sh
. ~/.bashrc

# Git LFS
. scripts/gitlfs_setup.sh

pip install wandb
