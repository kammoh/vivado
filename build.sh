#!/bin/sh
VERSION="2018.2_0614_1954"
TARBALL=Xilinx_Vivado_SDK_${VERSION}.tar.gz
IMAGE_PATH=/kamyar
TAG=vivado

docker image build --build-arg VERSION=${VERSION} -t $TAG --squash --rm --force-rm  . || exit 1
docker image save $TAG | gzip > ${IMAGE_PATH}/${TAG}.tar.gz || exit 1
