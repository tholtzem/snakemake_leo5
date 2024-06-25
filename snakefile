include: "rules/common.smk"

# -----------------------------------------------


rule all:
	input:
		## -- First test -- ##
		## use like this
		#expand('results/mapped/{sample}.bam', sample=['A', 'B', 'C'], ext=['bam'])
		## or using rules/common.smk to read in metadata
		expand('bbmap/{sample}.bam', sample=sample_names[0], ext=['bam']),
		## -- Pre-process your data -- ##
		expand('raw/qc/fastqc/{sample}_{pair}_001_fastqc.{ext}', pair=['R1', 'R2'], sample=sample_names[3], ext=['html', 'zip']),
		expand('trm/{sample}_{pair}.{ext}', pair=['R1', 'R2'], sample=sample_names[3], ext=['trmd.fq.gz']),
		expand('trm/{sample}_{pair}.{ext}', pair=['R1', 'R2'], sample=sample_names[3], ext=['trmdfilt.fq.gz']),
		expand('trm/qc/fastqc/{sample}_{pair}.trmdfilt_fastqc.{ext}', pair=['R1', 'R2'], sample=sample_names[3], ext=['html', 'zip']),
		expand("KRAKEN2_RESULTS/{sample}_kraken2_classified.done", sample=sample_names[3])

# -----------------------------------------------

include: "rules/test.smk"
include: "rules/pre_processing.smk"
