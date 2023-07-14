#!/usr/bin/env bash

. ./vars.env
export USERUID=38317
echo "Setting USERID to $USERUID"
echo "You need to change when you deploy on a different server"
sleep 2
docker network create myappNET

#docker image build --network myappNET --build-arg USERUID=$USERUID -t shibb-sp .
docker image build --build-arg USERUID=$USERUID -t shibb-sp .

cp -p files/apache/index.html /home/toaivo/data/mysite/html
cp -p files/apache/index.html /home/toaivo/data/mysite/html/secure

