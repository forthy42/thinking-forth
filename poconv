#!/bin/bash
# convert with potrace

for i in $*
do
  convert $i ${i%png}pgm
  potrace -r 600 -t 16 -a 1.334 -O 4 -u 1 -e -3 -c -q ${i%png}pgm -o ${i%png}eps
  rm ${i%png}pgm
done
