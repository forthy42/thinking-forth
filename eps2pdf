#!/bin/bash

# Convert eps to pdf, using the bounding box

for i in $*
  do
  echo "Converting $i"
  grep '%%BoundingBox' $i | while read box x y w h;
    do
    ps2pdf -g"$[w+1]x$[h+1]" -r72x72 $i ${i%eps}pdf
  done
done
