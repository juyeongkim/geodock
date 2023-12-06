# GeoDock Nextflow Pipeline

A Nextflow pipeline based on [GeoDock](https://github.com/Graylab/GeoDock).

## Running Nextflow

### Install Nextflow

Follow this to install Nextflow: https://www.nextflow.io/docs/latest/getstarted.html

### Pull Nextflow pipeline

```sh
nextflow pull juyeongkim/geodock
```

Downloaded pipeline are stored in the folder `$HOME/.nextflow/assets`.

### Run pipeline

| `--partner1` | `--partner2` | `--output` |
| ------------ | ------------ | ---------- |
| 1.pdb        | x.pdb        | 1._.x.pdb  |
| 2.pdb        | y.pdb        | 1._.y.pdb  |
| 3.pdb        |              | 2._.x.pdb  |
| 4.pdb        |              | 2._.y.pdb  |
|              |              | 3._.x.pdb  |
|              |              | 3._.y.pdb  |
|              |              | 4._.x.pdb  |
|              |              | 4._.y.pdb  |

#### A) Locally

```sh
cd /where/you/want/to/store/logs/and/intermediate/files
nextflow pull juyeongkim/geodock
nextflow run juyeongkim/geodock -r main --partner1 /your/partner1/dir --partner2 /your/partner2/dir --output /your/output/dir
```

#### B) Cluster

Alternatively, you can run the pipeline on HPC with slurm. First, load the environment modules if they are available. If not, please follow the Apptainer and Nextflow documentation to install them first.

```sh
module load Apptainer
module load Nextflow

cd /where/you/want/to/store/logs/and/intermediate/files
nextflow pull juyeongkim/geodock
nextflow run juyeongkim/geodock -r main -profile cluster --partner1 /your/partner1/dir --partner2 /your/partner2/dir --output /your/output/dir
```
