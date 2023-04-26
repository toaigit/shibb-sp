#!/bin/bash

. ./vars.env

cd files/shibb
rm sp*.pem
./keygen.sh -h $SITENAME
./genmeta.sh
