FROM debian:stretch

MAINTAINER devops@nfq.com

RUN apt-get -qq update && apt-get -qq -y install curl bzip2 gcc g++ \
    && curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local \
    && rm -rf /tmp/miniconda.sh \
    && conda install -y python=3 \
    && conda update conda \
    && apt-get -qq -y remove curl bzip2 \
    && apt-get -qq -y autoremove \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log \
    && conda clean --all --yes \
    && ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime

RUN pip install scipy pandas Sphinx Cython pyarrow coverage matplotlib gtable

ENV PATH /opt/conda/bin:$PATH
