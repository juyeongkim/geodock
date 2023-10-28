#!/usr/bin/env nextflow
nextflow.enable.dsl=2

SOURCE = Channel.fromPath("${params.source}/*.pdb").map {[it.name, it]}
TARGET = Channel.fromPath("${params.target}/*.pdb").map {[it.name, it]}

process GEODOCK {
  publishDir "${params.output}", mode: 'link'

  input:
  tuple val(source_id), path(source_file, stageAs: 'source/*'), val(target_id), path(target_file, stageAs: 'target/*')

  output:
  path "${source_id}_${target_id}.pdb"

  script:
  """
  import torch
  from geodock.GeoDockRunner import GeoDockRunner
  torch.cuda.empty_cache()
  ckpt_file = "/GeoDock/geodock/weights/dips_0.3.ckpt"
  geodock = GeoDockRunner(ckpt_file=ckpt_file)
  pred = geodock.dock(
      partner1="${source_file}",
      partner2="${target_file}",
      out_name="${source_id}_${target_id}",
      do_refine=True,
      use_openmm=True,
  )
  """
}

workflow {
  GEODOCK(SOURCE.combine(TARGET))
}
