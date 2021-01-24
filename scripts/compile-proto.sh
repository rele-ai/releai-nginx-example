#!/bin/bash

PATH="$HOME/go/bin:$PATH"; export PATH;
GOPATH="$HOME/devel/googleapis:$HOME/go:$GOPATH"; export GOPATH;

protoc \
    -I ./integratedapp \
    -I $GOPATH \
    --go_out ./integratedapp \
    --go_opt paths=source_relative \
    --go-grpc_out ./integratedapp \
    --go-grpc_opt paths=source_relative \
    "integratedapp.proto"
