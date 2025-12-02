#!/bin/bash
#SBATCH --job-name=mafft_bahd
#SBATCH --time=01:00:00
#SBATCH --mem=4G
#SBATCH --cpus-per-task=1
#SBATCH --output=mafft_bahd.%j.out
#SBATCH --account=PAS2880

# Activate conda and the blast_env environment
source ~/.bashrc
conda activate blast_env

cd "${SLURM_SUBMIT_DIR}"

bash scripts/run_mafft_bahd_protein.sh