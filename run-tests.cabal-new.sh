#!/bin/bash -e

cabal new-build haddock html-test hypsrc-test hoogle-test driver-test latex-test

mkdir -p bin
for i in $(find dist-newstyle/build/ -executable -a -type f -a -! -iname '*.so'); do
    f="`pwd`/$i"
    ln -fs $f bin/$(basename $i)
done

test_args="--haddock-path=bin/haddock --haddock-options=-lhaddock-api/resources"

echo html-test
bin/html-test $test_args

echo hypsrc-test
bin/hypsrc-test $test_args

echo hoogle-test
bin/hoogle-test $test_args

echo latex-test
bin/latex-test $test_args

echo driver-test
bin/driver-test
