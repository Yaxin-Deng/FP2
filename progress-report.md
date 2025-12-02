## BLAST Objective 1 — Identify the Atropa homolog(s) of the Datura tigloyl acyltransferase (TS) candidate

The first BLAST task focuses on confirming which Atropa BAHD coding sequences correspond to the Datura stramonium tigloyl acyltransferase ortholog (ANN22971).

To achieve this, I use the Datura TS CDS as a query and perform a nucleotide BLAST (blastn) search against a set of Atropa BAHD CDS sequences (“BAHD_ref.fa”). This set includes multiple isoforms of the Atropa aba_locus_5896 gene, which is suspected to encode the Atropa TS enzyme.

This analysis will determine:

the closest Atropa homolog of the Datura TS candidate,

percent identity and coverage between isoforms,

whether multiple Atropa transcripts represent alternative isoforms of the same locus.

This step establishes the direct orthology relationship between Datura and Atropa TS candidates.

## BLAST Objective 2 — Classify the Atropa and Datura TS candidates within the broader BAHD acyltransferase family (using Fig. 2E from Zeng (2024))

The second BLAST analysis aims to place the TS candidates from Atropa and Datura into the functional context of the BAHD acyltransferase family.

For this, I compile a protein reference set containing all enzymes shown in Fig. 2E, representing characterized BAHD clades (including CrDAT, MAT, SATs, ASATs, and TS). I then perform protein BLAST (blastp) using:

Query: Atropa + Datura TS/TS-like protein sequences

Database: the BAHD reference proteins from "Discovering a mitochondrion-localized BAHDacyltransferase involved in calystegine biosynthesis and engineering the production of3β-tigloyloxytropane" Fig. 2E and supplymentary data.

This analysis will identify:

which known BAHD enzyme each TS candidate most closely resembles,

whether the Atropa and Datura sequences cluster within the expected clade (clade 3),

functional inferences based on similarity to enzymes with known acyl donor or acceptor specificities.

Together, these two BLAST analyses establish both (1) orthology between Atropa and Datura TS enzymes and (2) their placement within the broader BAHD family.


Below is an overview of all scripts I plan to include in the final project.

## 1.1 Shell scripts (Bash)
(A) 02_blast/run_blast_db.sh

Purpose:

Build BLAST databases using reference BAHD sequences

Run blastn/blastp for CDS/protein comparisons

```bash
module spider miniconda
module load miniconda3/24.1.2-py310
conda --version
```
The output was:
```
miniconda3: miniconda3/24.1.2-py310
This module can be loaded directly: module load miniconda3/24.1.2-py310

conda 24.1.2
```
I created an environment called blast_env and activate it.

```bash
conda create -n blast_env -c bioconda -c conda-forge blast

y

conda activate blast_env
```
The ourput was:
```
Proceed ([y]/n)? y
Downloading and Extracting Packages:
Preparing transaction: done                                        
Verifying transaction: done                                        
Executing transaction: done  
# To activate this environment, use        
#     $ conda activate blast_env                 
# To deactivate an active environment, use        
#     $ conda deactivate
```
Check if BLAST+ was successful
```bash
which blastn
which makeblastdb
blastn -version
```
The output was:
```
~/.conda/envs/blast_env/bin/blastn
~/.conda/envs/blast_env/bin/makeblastdb
blastn: 2.17.0+
 Package: blast 2.17.0, build Aug 11 2025 09:46:06
```
## （A）Nucleic acid level: Datura TS CDS vs Atropa BAHD CDS

Objective: To identify which CDS from Atropa is the best homolog of Datura TS.

Query：00_raw/ANN22971_Ds_TA_ortholog.fna（Datura TS candidate CDS）

DB：00_raw/BAHD_ref.fa

```bash
makeblastdb -in ./TS_BAHD_project/00_raw/BAHD_ref.fa -dbtype nucl
```
The output was:
```
Building a new DB, current time: 12/01/2025 23:04:50
New DB name:   /fs/ess/PAS2880/users/dengyaxin1156/TS_BAHD_project/00_raw/BAHD_ref.fa
New DB title:  ./TS_BAHD_project/00_raw/BAHD_ref.fa
Sequence type: Nucleotide
Keep MBits: T
Maximum file size: 3000000000B
Adding sequences from FASTA; added 4 sequences in 0.0838192 seconds.
```

```bash
blastn -query ANN22971_Ds_TA_ortholog.fna -db BAHD_ref.fa -outfmt 6 > blast_DsTS_vs_AtropaBAHD.tab
```
## (B) Protein Level: Datura + Atropa TS Protein vs. BAHD Protein in Fig. 2E

Objective: To compare Atropa/Datura TS candidates within the entire BAHD family (especially clade 3) to determine which type of BAHD enzyme they most closely resemble.

Currently available files:

00_raw/BAHD_Fig2E_all.fa

All BAHD proteins in Fig.2E (functions known, with annotations such as TS)

00_raw/Clade3_Protein.fa

Contains clade 3 proteins from Fig.2E + Datura stramonium candidate (MCD7454679.1), etc.

1) Using BAHD from Fig.2E as the DB:
```bash
makeblastdb -in BAHD_Fig2E_all.fa -dbtype prot
```
The output was:
```
Building a new DB, current time: 12/01/2025 23:13:44
New DB name:   /fs/ess/PAS2880/users/dengyaxin1156/TS_BAHD_project/00_raw/BAHD_Fig2E_all.fa
New DB title:  BAHD_Fig2E_all.fa
Sequence type: Protein
Keep MBits: T
Maximum file size: 3000000000B
Adding sequences from FASTA; added 19 sequences in 0.00455308 seconds.
```
2) Using Clade3_Protein.fa (containing Datura + Atropa TS candidates) as the query:

```bash
blastp -query Clade3_Protein.fa -db BAHD_Fig2E_all.fa -outfmt 6 > blast_TS_candidates_vs_Fig2E_BAHD.tab
```
## find motifs of BAHD family gene
```bash
conda install -c bioconda mafft
mafft --version
```
The output was:
```
v7.525 (2024/Mar/13)
```

```bash

sbatch scripts/submit_mafft_bahd.slurm
The output was:
```

v7.525 (2024/Mar/13)
Submitted batch job 42200549
squeue -u dengyaxin1156
cat mafft_bahd.42200549.out
```
The output was:
```
 JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
          42195706       cpu ondemand dengyaxi  R    7:22:05      1 p0222
```



