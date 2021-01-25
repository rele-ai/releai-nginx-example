#!/bin/bash

############ VARS ############
APP_ID=""
APP_HASH=""

TOKEN=$(echo -ne $APP_ID:$APP_HASH | base64)
HOST="127.0.0.1"
PORT="443"
PROTO_DIR="./integratedapp"
GOOGLE_APIS_DIR="$HOME/devel/googleapis"
PAYLOAD='{
    "operation_key": "hello_world",
    "payload": {
        "foo": {
            "bar": "baz"
        }
    }
}'

############ REQUEST ############

grpcurl \
    -plaintext \
    -import-path "$PROTO_DIR" \
    -import-path "$GOOGLE_APIS_DIR" \
    -d "$PAYLOAD" \
    -proto integratedapp.proto \
    -H "Authorization: Basic $TOKEN" \
    "$HOST:$PORT" \
    integratedapp.IntegratedApps.Notify
