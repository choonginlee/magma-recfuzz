#!/bin/bash
set -e

##
# Pre-requirements:
# - env FUZZER: path to fuzzer work dir
##

if [ ! -d "$FUZZER/repo" ]; then
    echo "fetch.sh must be executed first."
    exit 1``
fi


# Install AFL for instrumentation
cd "$FUZZER/repo/afl"
CC=clang make -j $(nproc) > /dev/null 2>&1
CC=clang make -j $(nproc) -C llvm_mode > /dev/null 2>&1

# Install RecFuzz
# prerequisite
apt-get install -y libjson-c-dev libssl-dev libxml2-dev > /dev/null 2>&1
cd "$FUZZER/repo"
tar -xf initial_result_magma.tar
make -j $(nproc) 2>&1

# compile afl_driver.cpp
echo "Compiling afl_driver for recfuzz..." # debug
"$FUZZER/repo/afl/afl-clang-fast++" $CXXFLAGS -std=c++11 -c "afl/afl_driver.cpp" -fPIC -o "$OUT/afl_driver.o" 2>&1
