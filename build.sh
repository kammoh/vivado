#!/bin/sh
VERSION="2018.2_0614_1954"
TAR_DIR=../
TARBALL=Xilinx_Vivado_SDK_${VERSION}.tar.gz
PORT=8000

pushd
cd installer
python -m http.server 8000 &
P1=$!
popd
docker image build --rm --force-rm --squash --build-arg VERSION=${VERSION} HOST=localhost:${PORT} -t vivado .

kill $P1
kill -KILL $P1
