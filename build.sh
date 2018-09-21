#!/bin/sh
VERSION="2018.2_0614_1954"
TARBALL=Xilinx_Vivado_SDK_${VERSION}.tar.gz
docker build --build-arg VERSION=${VERSION} -t vivado .
