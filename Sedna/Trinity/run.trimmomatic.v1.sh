#!/bin/bash

#SBATCH --job-name=TrimmomaticNose
#SBATCH -c 20
#SBATCH -t 0
#SBATCH --mail-user=giles.goetz@noaa.gov
#SBATCH --mail-type=ALL

# Fix for using conda with 
source ~/.bashrc

# Load Trimmomatic environment
mamba activate trimmomatic-0.39

# Setup
BASE=/share/nwfsc/ggoetz/202310-terra_gcp-trinity
IN=${BASE}/raw
OUT=${BASE}/trimmed

# Trimmomatic Adapter Folder
ADAPTER_FOLDER=/opt/bioinformatics/mambaforge/envs/trimmomatic-0.39/share/trimmomatic/adapters

# Create output folder if it doesn't exist
if [ ! -d ${OUT} ]; then
    mkdir -p ${OUT}
fi

cd ${BASE}

# Loop through the samples
SAMPLES=$(ls ${IN}/*R1*.gz | \
    awk -F "/" '{print $NF}' | \
    awk -F "." '{print $1}')

for SAMPLE in ${SAMPLES}
do
    # Run Trimmomatic
    trimmomatic \
        PE \
        -threads 20 \
        ${IN}/${SAMPLE}.R1.fq.gz \
        ${IN}/${SAMPLE}.R2.fq.gz \
        ${OUT}/${SAMPLE}.trimmed.paired.R1.fq.gz \
        ${OUT}/${SAMPLE}.trimmed.unpaired.R1.fq.gz \
        ${OUT}/${SAMPLE}.trimmed.paired.R2.fq.gz \
        ${OUT}/${SAMPLE}.trimmed.unpaired.R2.fq.gz \
        ILLUMINACLIP:${ADAPTER_FOLDER}/TruSeq3-PE-2.fa:2:30:10 \
        LEADING:3 \
        TRAILING:3 \
        SLIDINGWINDOW:4:20 \
        MINLEN:50 \
        &> ${OUT}/${SAMPLE}.trim.log
done
