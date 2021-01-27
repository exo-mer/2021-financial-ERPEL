#!/bin/sh

################################################################################
# Name        : erpel/build.sh                                                 #
# Author      : M.E.Rosner                                                     #
# E-Mail      : marty[at]rosner[dot]io                                         #
# Version     : 0.0.01                                                         #
# Copyright   : Copyright (C) 2020, 2021 M.E.Rosner; Berlin; Germany           #
# Description : An Enterprise Ressource Planning Notation and Tool Kit         #
# URL         : https://github.com/exo-mer/2021-financial-ERPEL                #
################################################################################

# build process using make
cd src/
make clean
make
[ ! -d build ] && mkdir ../build
mv test-erpel ../build/
make clean
cd ../
# ./build/test-erpel

echo 'Running ./build/test-erpel\n'

echo 'Using: ./examples/more-complex-structure.txt'
./build/test-erpel < ./examples/more-complex-structure.txt
echo '\n'

echo 'Using: ./examples/simple-002-structure.txt'
./build/test-erpel < ./examples/simple-002-structure.txt
echo '\n'

echo 'Using: ./examples/simple-001-structure.txt'
./build/test-erpel < ./examples/simple-001-structure.txt
echo '\n'
