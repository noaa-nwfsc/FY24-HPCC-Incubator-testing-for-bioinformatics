#!/bin/bash

#SBATCH --job-name=Amethyst
#SBATCH -c 20
#SBATCH -t 0
#SBATCH --mail-user=giles.goetz@noaa.gov
#SBATCH --mail-type=ALL

# so we can use conda with the scheduler
source ~/.bashrc

# load the snakemake environment
#mamba activate snakemake-7.32.4
mamba activate snakemake-8.4.12

# Switch to the main amethyst folder
cd /share/nwfsc/ggoetz/202311-terra_gcp-amethyst/t2/amethyst

# Kickoff snakemake
snakemake \
    -s Snakefile \
    --use-conda \
    --cores 20 \
    -p \
    --latency-wait 90 \
    &> snakemake.amethyst.log
