#!/bin/bash
for i in $*
do grep '%%BoundingBox' $i | while read bbox x y w h
    do sed -e "s/$bbox $x $y $w $h/$bbox $x $y $[w*72/600] $[h*72/600]/g" \
	-e 's/%%BeginSetup/%%BeginSetup\n.12 dup scale/g' <$i >$i+
    mv $i+ $i
  done
done
