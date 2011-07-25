#!/bin/sh

# Quick hack to extract and compile all external dependencies.
# Author:   Pontus Stenetorp    <pontus stenetorp se>
# Version:  2011-06-07

ARCH_DIR='external'

LIBLINEAR='liblinear-1.7'
SIMSTRING='simstring-1.0'

(
cd ${ARCH_DIR} && rm -rf ${LIBLINEAR} && tar xfz ${LIBLINEAR}.tar.gz && \
    cd ${LIBLINEAR} && make && cd python && make
    ) && (

# iconv flag to work around:
#   https://github.com/chokkan/simstring/pull/4
cd ${ARCH_DIR} && rm -rf ${SIMSTRING} && tar xfz ${SIMSTRING}.tar.gz && \
    cd ${SIMSTRING} && ./configure && cd swig/python && ./prepare.sh && \
    python setup.py build_ext --inplace -l iconv && python -c 'import simstring'
)
