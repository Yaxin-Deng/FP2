#!/usr/bin/env bash
# run_mafft_bahd_protein.sh
# Goal
#   Use MAFFT to align BAHD protein sequences (including Atropa + Datura TS candidates)
# Project Context:
#   The input file (Clade3_Protein.fa) contains:
#     - Datura stramonium tigloyl acyltransferase (TS) candidate protein
#     - Atropa BAHD clade 3 homologs
#     - BAHD enzymes from Fig. 2E
#   These sequences will be aligned to support:
#     - motif identification (HXXXD, DFGWG)
#     - BLAST interpretation
#     - family-level classification of TS candidates
#
# Location:
#   This script is located in TS_BAHD_project/scripts/
#   and uses data stored in TS_BAHD_project/00_raw/

set -euo pipefail

echo "Using MAFFT from conda environment (v7.525)..."

INPUT="../00_raw/Clade3_Protein.fa"
OUTPUT="../03_localization/Clade3_Protein_aligned.fa"

mkdir -p ../03_localization

echo "Running MAFFT alignment on BAHD family protein sequences..."
echo "Input : ${INPUT}"
echo "Output: ${OUTPUT}"

mafft --auto "${INPUT}" > "${OUTPUT}"

echo "MAFFT alignment completed."
echo "Aligned file written to: ${OUTPUT}"