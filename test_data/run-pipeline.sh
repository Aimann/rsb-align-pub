#!/bin/bash

## run the snakemake pipeline

# Exit on error
set -e

# Activate conda environment
# This path might differ based on your Miniconda installation in the container
source /opt/conda/etc/profile.d/conda.sh
conda activate ribomarker

# Print what we are about to run (helpful in debugging)
echo "Running Snakemake with arguments: $@"

snakemake --unlock

# ##just run the pipeline, no docker
snakemake --configfile config.yaml --cores 20 --rerun-incomplete 2>&1 | tee /pipeline/data/snakemake.log
