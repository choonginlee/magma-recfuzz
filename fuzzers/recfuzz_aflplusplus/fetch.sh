#!/bin/bash
set -e

##
# Pre-requirements:
# - env FUZZER: path to fuzzer work dir
##
git clone https://choonginlee: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@github.com/choonginlee/recfuzz.git "$FUZZER/repo" 2>&1
git clone --no-checkout https://github.com/google/AFL.git "$FUZZER/repo/afl" 2>&1
git -C "$FUZZER/repo/afl" checkout 61037103ae3722c8060ff7082994836a794f978e 2>&1

cp "$FUZZER/src/afl_driver.cpp" "$FUZZER/repo/afl/afl_driver.cpp"
