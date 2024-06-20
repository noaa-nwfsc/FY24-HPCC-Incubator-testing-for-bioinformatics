#!/bin/bash

#SBATCH --job-name=Trinity
#SBATCH -c 24
#SBATCH -t 0
#SBATCH --mail-user=giles.goetz@noaa.gov
#SBATCH --mail-type=ALL

# Using a himem node since we probably need more than 200 GB
#SBATCH -p himem

# so we can use conda with the scheduler
source ~/.bashrc

# load the trinity environment
mamba activate trinity-2.15.1

VER=1

# Setup
BASE=/share/nwfsc/ggoetz/202310-terra_gcp-trinity
IN=${BASE}/trimmed
OUT=${BASE}/trinity/trinity.all.v${VER}

if [ ! -d ${OUT} ]; then
    mkdir -p ${OUT}
fi

# Get a list of the files, only using the paired trimmed ones
FILES_R1=$(ls ${IN}/*.paired.R1.*.gz | tr '\n' ',' | sed -e 's/,$//')
FILES_R2=$(ls ${IN}/*.paired.R2.*.gz | tr '\n' ',' | sed -e 's/,$//')

# Running Trinity, setting a really high memory limit since
# we don't know how much it is going to use.
Trinity \
    --seqType fq \
    --CPU 24 \
    --output ${OUT} \
    --max_memory 1200G \
    --left ${FILES_R1} \
    --right ${FILES_R2} \
    &> ${OUT}/trinity.log
