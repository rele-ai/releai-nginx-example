#!/bin/bash

SCRIPT_DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
PATH_TO_CERTIFICATES_DIR="$SCRIPT_DIR/../proxy/certificates/"

openssl \
    req \
    -x509 \
    -nodes \
    -newkey \
    rsa:4096 \
    -keyout $PATH_TO_CERTIFICATES_DIR/client.key \
    -out $PATH_TO_CERTIFICATES_DIR/client.crt \
    -days 365
