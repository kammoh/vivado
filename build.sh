#!/bin/sh
docker build --build-arg SETUP=`ls -1 Xilinx_Vivado_SDK_Web*.bin | head -1` -t kammoh/vivado .
