#!/usr/bin/env bash

export USERUID=1000
echo "Setting USERID to $USERUID"
echo "You need to change when you deploy on a different server"
sleep 2
docker network create myappNET

docker image build --network myappNET --build-arg USERUID=$USERUID -t my1stapp .

