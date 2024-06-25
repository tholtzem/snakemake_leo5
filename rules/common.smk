###-------------------------------------------------------------------------###
## Input config file and python code for sample sheets and helper functions
###-------------------------------------------------------------------------###

configfile:
  "config/config.yaml"

import os
import pandas as pd

## load file with sample metadata
samples_info = pd.read_csv("list/samples.tsv", sep='\t', index_col=False)
sample_names = list(samples_info['fastq_ID'])
sample_dir = list(samples_info['fastq_dir'])
samples_dict = dict(zip(sample_names, sample_dir))


###### helper functions ######

def getFqHome(sample):
  return(list(os.path.join(samples_dict[sample],"{0}_{1}_001.fastq.gz".format(sample,pair)) for pair in ['R1','R2']))


def getKrakenHome(sample):
    return(list(os.path.join("KRAKEN2_RESULTS/","{0}_{1}.trmdfilt.keep.fq.gz".format(sample,pair)) for pair in ['R1','R2']))

