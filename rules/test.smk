rule map_reads:
  input:
    read = "raw/{sample}.fastq",
    ref = config['ref']
  output:
    "bbmap/{sample}.bam"
  log: "log/{sample}.log"
  threads: 1
  resources: mem_mb=120000, walltime="00:00:30"
  message: """ Simple example for mapping with bbmap and sam2bam using samtools """
  shell:
    """
    bbmap.sh -Xmx{resources.mem_mb}m in={input.read} ref={input.ref} out=stdout.sam | samtools view -Sb - > {output}
    """

