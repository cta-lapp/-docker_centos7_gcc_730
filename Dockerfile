#FROM centos:7.3.1611
FROM centos:7.2.1511

MAINTAINER Jean J.  <jacquem@lapp.in2p3.fr>

ENV LANG=en_US.UTF-8

RUN yum install -y yum-plugin-ovl
RUN yum clean all

RUN yum -y update

RUN yum install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh

ENV PATH /opt/conda/bin:$PATH

RUN conda create -n hipetest python=3

#RUN source activate hipetest && \
#    conda install -y -c cta-observatory ctapipe

RUN source activate hipetest && \
    cd /opt && \
    wget http://ftp.mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-7.3.0/gcc-7.3.0.tar.gz && \
    tar zxf gcc-7.3.0.tar.gz 

 
RUN yum -y  install  gcc-c++

RUN yum -y install make cmake

RUN source activate hipetest && \
    cd /opt/gcc-7.3.0 && \
    ./contrib/download_prerequisites && \
    ./configure --disable-multilib --enable-languages=c,c++ && \
    make -j 4 && \

    make install
   

