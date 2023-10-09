#!/bin/bash

##
# Pre-requirements:
# - env FUZZER: path to fuzzer work dir
# - env TARGET: path to target work dir
# - env OUT: path to directory where artifacts are stored
# - env SHARED: path to directory shared with host (to store results)
# - env PROGRAM: name of program to run (should be found in $OUT)
# - env ARGS: extra arguments to pass to the program
# - env FUZZARGS: extra arguments to pass to the fuzzer
##


# 기본적으로 target 별 configrc 에서 정해준 ARGS가 있음. 확인 필요
n=${#ARGS}
if [ $n -eq 0 ]
    then 
        FUZZARGS="-S"
fi


# if nm "$OUT/afl/$PROGRAM" | grep -E '^[0-9a-f]+\s+[Ww]\s+main$'; then
#     ARGS="-"
# fi

mkdir -p "$SHARED/findings"
# echo core > /proc/sys/kernel/core_pattern
ulimit -c unlimited

# export AFL_SKIP_CPUFREQ=1
# export AFL_NO_AFFINITY=1

# For testing dryrun
# echo $FUZZER/repo/recfuzz -q -i $FUZZER/repo/initial_result_magma/aflplusplus_halfcrash/$PROGRAM $FUZZARGS -f "$OUT/$PROGRAM $ARGS" -s random-only
# $FUZZER/repo/recfuzz -q -i $FUZZER/repo/initial_result_magma/aflplusplus_halfcrash/$PROGRAM $FUZZARGS -f "$OUT/$PROGRAM $ARGS" -s random-only

cp $FUZZER/repo/bt.gdb ./
cp $FUZZER/repo/bt-run.gdb ./
echo $FUZZER/repo/recfuzz -q -i $FUZZER/repo/initial_result_magma/aflplusplus_halfcrash/$PROGRAM $FUZZARGS -o "$SHARED/findings/output" -f "$OUT/$PROGRAM $ARGS" -s random-only
$FUZZER/repo/recfuzz -q -i $FUZZER/repo/initial_result_magma/aflplusplus_halfcrash/$PROGRAM $FUZZARGS -o "$SHARED/findings/output" -f "$OUT/$PROGRAM $ARGS" -s random-only