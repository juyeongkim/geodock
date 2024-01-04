#!/usr/bin/env nextflow
nextflow.enable.dsl=2

Partner1 = Channel.fromPath("${params.partner1}/*.pdb")
Partner2 = Channel.fromPath("${params.partner2}/*.pdb")

process GEODOCK {
  publishDir "${params.output}", mode: 'copy'

  input:
  tuple path(partner1, stageAs: 'partner1/*'), path(partner2, stageAs: 'partner2/*')

  output:
  path "${partner1.simpleName}._.${partner2.simpleName}.pdb"

  script:
  """
  #!/usr/bin/env python
  import torch
  from geodock.GeoDockRunner import GeoDockRunner
  torch.cuda.empty_cache()
  torch.set_num_threads(${task.cpus})
  ckpt_file = "/GeoDock-main/geodock/weights/dips_0.3.ckpt"
  geodock = GeoDockRunner(ckpt_file=ckpt_file)
  pred = geodock.dock(
      partner1="${partner1}",
      partner2="${partner2}",
      out_name="${partner1.simpleName}._.${partner2.simpleName}",
      do_refine=True,
      use_openmm=True,
  )
  """
}

workflow {
  Partner1 |
    combine(Partner2) |
    GEODOCK
}
