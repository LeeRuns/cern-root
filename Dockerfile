FROM centos:latest
MAINTAINER alexander.mazurov <alexander.mazurov@gmail.com>
ARG version="6.09.02"
LABEL description="CERN ROOT framework"
LABEL version="${version}"

RUN yum -y install epel-release gcc-c++ bzip2 git vim cmake3 libpng libjpeg \
     python-devel libSM libX11 libXext libXpm libXft\
     && yum -y clean all
RUN yum -y install python-pip && yum -y clean all
RUN pip install --upgrade pip && pip install jupyter
RUN ln -s /usr/bin/cmake3 /usr/bin/cmake

# Set ROOT environment
ENV ROOTSYS         "/opt/root"
ENV PATH            "$ROOTSYS/bin:$ROOTSYS/bin/bin:$PATH"
ENV LD_LIBRARY_PATH "$ROOTSYS/lib:$LD_LIBRARY_PATH"
ENV PYTHONPATH      "$ROOTSYS/lib:PYTHONPATH"

ADD https://root.cern.ch/download/root_v${version}.Linux-centos7-x86_64-gcc4.8.tar.gz /var/tmp/root.tar.gz
RUN tar xzf /var/tmp/root.tar.gz -C /opt && rm /var/tmp/root.tar.gz
