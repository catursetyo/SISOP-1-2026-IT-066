#!/bin/bash

x1=-7.920000
x2=-7.937960

y1=112.450000
y2=112.468100

koorX=$(awk "BEGIN {print ($x1 + $x2) / 2}")
koorY=$(awk "BEGIN {print ($y1 + $y2) / 2}")
echo -e "Koordinat pusat:\n$koorX, $koorY"