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

ARG SETUP
ADD install_config.txt /tmp/install_config.txt
ENV SETUP ${SETUP}
ADD ${SETUP} /tmp/${SETUP}
RUN chmod +x /tmp/${SETUP}
RUN /tmp/${SETUP} --nox11 --noexec --target /opt/vivado_installer
RUN rm -rf /tmp/${SETUP}

RUN /opt/vivado_installer/xsetup --agree 3rdPartyEULA,WebTalkTerms,XilinxEULA  -e "Vivado HL WebPACK" --location "/opt/Xilinx" -c /tmp/install_config.txt --batch Interactive

#RUN rm -rf /opt/vivado_installer

#RUN /tmp/Xilinx_Vivado_SDK_2017.3_1005_1/xsetup --agree 3rdPartyEULA,WebTalkTerms,XilinxEULA --batch Install -c /tmp/install_config.txt
#RUN rm -rf /tmp/*

#RUN adduser --disabled-password --gecos '' vivado
#USER vivado
#WORKDIR /home/vivado
#RUN echo source /opt/Xilinx/Vivado/${vversion}/settings64.sh >> /home/vivado/.bashrc
