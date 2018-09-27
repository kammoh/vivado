FROM debian:stable-slim
MAINTAINER Kamyar Mohajerani <kammoh@gmail.com>

RUN apt-get update && apt-get install -y \
        curl \
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
ARG SERVE_HOST
COPY install_config.txt /tmp/install_config.txt
ENV VERSION=${VERSION}
ENV TARBALL=Xilinx_Vivado_SDK_${VERSION}.tar.gz
RUN curl http://${SERVE_HOST}/${TARBALL} | tar -xzC /tmp/

RUN bash /tmp/Xilinx_Vivado_SDK_${VERSION}/xsetup --agree 3rdPartyEULA,WebTalkTerms,XilinxEULA  -e "Vivado HL WebPACK" --location "/opt/Xilinx" -c /tmp/install_config.txt --batch Install
