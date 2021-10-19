FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04

RUN apt update && apt install -y sudo wget vim
WORKDIR /opt

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    sh Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda3 && \
    rm -r Miniconda3-latest-Linux-x86_64.sh

ENV PATH /opt/miniconda3/bin:$PATH

COPY environment.yml .

RUN pip install --upgrade pip && \
    conda update -n base -c defaults conda && \
    conda env create -n finbert -f environment.yml && \
    conda init && \
    echo 'conda activate finbert' >> ~/.bashrc

ENV CONDA_DEFAULT_ENV finbert && \
    PATH /opt/conda/envs/finbert/bin:$PATH

WORKDIR /var/www

CMD ["/bin/bash"]
