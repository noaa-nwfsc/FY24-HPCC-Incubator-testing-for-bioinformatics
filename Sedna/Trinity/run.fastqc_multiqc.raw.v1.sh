#!/bin/bash

#SBATCH --job-name=FASTQC
#SBATCH -c 20
#SBATCH -t 0
#SBATCH --mail-user=giles.goetz@noaa.gov
#SBATCH --mail-type=ALL

# Fix for using conda with 
source ~/.bashrc

# Load the FastQC environment
mamba activate fastqc-0.12.1

# Setup base variables
BASE=/share/nwfsc/ggoetz/202310-terra_gcp-trinity
IN=${BASE}/raw
OUT=${BASE}/fastqc/raw

# Create output folder if it doesn't exist
if [ ! -d ${OUT} ]; then
    mkdir -p ${OUT}
fi

cd ${BASE}

# Running FastQC
fastqc \
    -t 20 \
    -o ${OUT} \
    ${IN}/*.gz \
    &> ${OUT}/fastqc.log

# Switch to MultiQC environment
mamba activate multiqc-1.17

cd ${OUT}

# Run MultiQC
multiqc .
