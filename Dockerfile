FROM pytorch/pytorch:2.1.0-cuda12.1-cudnn8-runtime
RUN apt-get update -q && apt-get install -q -y unzip wget
# https://github.com/openmm/openmm/issues/3943
RUN conda install -y -c conda-forge libstdcxx-ng
RUN conda install -y -c conda-forge openmm pdbfixer
RUN pip install geodock
RUN pip install torch-geometric
RUN pip install torch-scatter -f https://pytorch-geometric.com/whl/torch-2.1.0+cu121.html
RUN pip install torch-sparse -f https://pytorch-geometric.com/whl/torch-2.1.0+cu121.html
RUN pip install torch-cluster -f https://pytorch-geometric.com/whl/torch-2.1.0+cu121.html
RUN pip install torch-spline-conv -f https://pytorch-geometric.com/whl/torch-2.1.0+cu121.html
RUN wget https://github.com/Graylab/GeoDock/archive/refs/heads/main.zip && \
  unzip main.zip
RUN wget -P /root/.cache/torch/hub/checkpoints https://dl.fbaipublicfiles.com/fair-esm/models/esm2_t33_650M_UR50D.pt
RUN wget -P /root/.cache/torch/hub/checkpoints https://dl.fbaipublicfiles.com/fair-esm/regression/esm2_t33_650M_UR50D-contact-regression.pt
