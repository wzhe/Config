#!/bin/bash

source install-pre.sh

$INSTALL build-essential
$INSTALL automake 
$INSTALL g++
$INSTALL gcc
$INSTALL clang

$INSTALL cmake
