#!/bin/bash

#SBATCH --job-name=Tourmaline-Test
#SBATCH -c 20
#SBATCH -t 0
#SBATCH --mail-user=giles.goetz@noaa.gov
#SBATCH --mail-type=ALL

# so we can use conda with the scheduler
source ~/.bashrc

mamba activate snakemake

VER=1

BASE=/share/nwfsc/ggoetz/202406-terra_gcp-tourmaline/tourmaline

cd ${BASE}

snakemake dada2_pe_taxonomy_unfiltered --cores 20 --use-conda --forceall
snakemake dada2_pe_diversity_unfiltered  --cores 20 --use-conda --forceall
snakemake dada2_pe_report_unfiltered --cores 20 --use-conda --forceall
