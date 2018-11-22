#!/bin/sh
VERSION="2018.2_0614_1954"
TAR_DIR=../
TARBALL=Xilinx_Vivado_SDK_${VERSION}.tar.gz
[ -n $SERVE_PORT ] && SERVE_PORT=8000
IMAGE_PATH=/kamyar
TAG=vivado

P1=

function serve_go()
{
cat <<- EOF | tee /tmp/serve.go | go run /tmp/serve.go
        package main
        import (
                "net/http"
                "log"
        )

        func main() {
                log.Fatal(http.ListenAndServe(":$SERVE_PORT", http.FileServer(http.Dir("."))))
        }
EOF
}


pushd $PWD
cd installer
python3 -m http.server $SERVE_PORT &
P1=$!

function die()
{

  [[ -n $P1 ]] && kill $P1
  [[ -n $P1 ]] && kill -KILL $P1

  echo "died"

  exit 1
}

trap ctrl_c INT

function ctrl_c() 
{
  die 
}

popd
docker image build --network=host --squash --build-arg VERSION=${VERSION} --build-arg SERVE_HOST=localhost:${SERVE_PORT} -t $TAG --squash --rm --force-rm . || die
docker image save $TAG | gzip > ${IMAGE_PATH}/${TAG}.tar.gz || die

