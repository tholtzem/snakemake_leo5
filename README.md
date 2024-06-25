# Test workflow for the execution of snakemake on leo5 (SLURM)

Testing the snakemake workflow for the execution on the leo5 HPC cluster with the SLURM batch job sumission system. 


======================================================

## 1) Create and load the Anaconda/Mamba environment


Mamba (https://github.com/mamba-org/mamba) is a reimplementation of the conda package manager in C++.

```
# Load Anaconda on cluster (here leo5):
module load Anaconda3/2023.10/miniconda-base-2023.10
 

# To use conda commands in your current shell session, first do:
eval "$(/$UIBK_CONDA_DIR/bin/conda shell.bash hook)"

# !!! In case you want to change the environment or create your own !!! 
## Create environment from yaml file (in envs/):
mamba env create -f env/s21.yaml -p $SCRATCH/envs/daphnia_test

# activate your own environment with
conda activate daphnia_test

# deactivate
conda deactivate

# Software can be installed/updated by modifying the envs/s21.yaml file.
# To use the modified conda environment, update with:
mamba env update --name daphnia_test --file envs/s21.yaml

# In case you want to remove the environment completely
conda env remove --n daphnia_test

# Users of the c770 group can simply activate the environment on leo5 with:
conda activate daphnia
```


## 2) Local execution of snakemake (for testing only, else not recommended!)

```
# dry-run
snakemake -n

# local execution (not recommended!)
snakemake --cores 1

```

## 3) Run snakemake via cluster execution on leo5

For more information on leo5 and slurm (https://www.uibk.ac.at/zid/systeme/hpc-systeme/common/tutorials/slurm-tutorial.html)

```
sbatch slurm/clusterSnakemake.sh

```

## Check cancel jobs

```

# check all jobs
sq

# check your jobs only
squ

# cancel job
scancel <JOBID>

# check usage of running job
## ssh to node (NODELIST)
ssh <NODELIST>
## on the compute node
top

# check usage after the job has completed
export SACCT_FORMAT="JobID%20,JobName,User,Partition,NodeList,Elapsed,State,ExitCode,MaxRSS,AllocTRES%32"
sacct -j <JOBID>

```

## Some information on the snakemake pipeline for the slurm based cluster (here leo5)

1. Testing and execution of snakemake in working directory (where your snakefile is located)

2. Slurm specific files and logs are in slurm/ directory
* cluster submission script for main job (slurm/clusterSnakemake.sh), change the job-name and mail-user!
* configuration profile for slurm (slurm/config.yaml)!
* sbatch log files (output & erro files) are sent to slurm/log/

3. The snakefile:
* contains the names of the output files (should correspond to the output in your rule)
* always includes the file rules/common.smk
* includes additional files with rules you want to execute (f.ex. rules/test.smk)

4. The rules/common.smk file:
* calls the input config file (config/config.yaml) and 
* contains python code for loading sample information (and helper functions)

5. The snakemake configuration file (config/config.yaml) contains the paths to adapters, Kraken2 database and references 

6. Sample information and metadata are in list/samples.csv

7. Data was downloaded from (https://github.com/snakemake/snakemake-tutorial-data/archive/v5.4.5.tar.gz)


======================================================


## Rules

### Test


See rules/test.smk: for a simple snakemake rule with bbmap 



### Pre-processing WGS data


See rules/pre_processing.smk: for executing pre-processing steps of raw WGS data in snakemake

For now, the file includes:

fastqc
adapter trimming
quality trimming



======================================================
