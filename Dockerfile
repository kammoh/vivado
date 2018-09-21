FROM debian:stable-slim
MAINTAINER Kamyar Mohajerani <kammoh@gmail.com>

RUN apt-get update && apt-get install -y \
  libxrandr2 \
        libx11-6 \
        libxext6 \
        libxrender1 \
        libxtst6 \
        libxi6 \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /src/*.deb

ARG VERSION
ADD install_config.txt /tmp/install_config.txt
ENV VERSION=${VERSION}
ENV TARBALL=Xilinx_Vivado_SDK_${VERSION}.tar.gz
ADD ${TARBALL} /tmp/
#RUN tar xvzf /tmp/x.tar.gz
#RUN rm -rf /tmp/x.tar.gz


RUN bash /tmp/Xilinx_Vivado_SDK_${VERSION}/xsetup --agree 3rdPartyEULA,WebTalkTerms,XilinxEULA  -e "Vivado HL WebPACK" --location "/opt/Xilinx" -c /tmp/install_config.txt --batch Install

#RUN rm -rf Xilinx_Vivado_SDK_${vivado_version}

#RUN adduser --disabled-password --gecos '' vivado
#USER vivado
#WORKDIR /home/vivado
#RUN echo source /opt/Xilinx/Vivado/${vversion}/settings64.sh >> /home/vivado/.bashrc
