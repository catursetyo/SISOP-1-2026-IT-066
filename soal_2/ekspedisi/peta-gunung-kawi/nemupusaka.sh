#!/bin/bash

input="titik-penting.txt"
output="posisipusaka.txt"

awk -F',' '
NR == 1 {
    min_lat = max_lat = $3
    min_lon = max_lon = $4
}
{
    if ($3 < min_lat) min_lat = $3
    if ($3 > max_lat) max_lat = $3
    if ($4 < min_lon) min_lon = $4
    if ($4 > max_lon) max_lon = $4
}
END {
    pusat_lat = (min_lat + max_lat) / 2
    pusat_lon = (min_lon + max_lon) / 2
    printf "Koordinat pusat:\n%.6f, %.6f\n", pusat_lat, pusat_lon
}
' "$input" > "$output"

cat "$output"