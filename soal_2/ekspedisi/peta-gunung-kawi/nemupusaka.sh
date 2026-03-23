#!/bin/bash

input="titik-penting.txt"
output="posisipusaka.txt"

awk -F',' '
NR == 1 {
    lat1 = $3
    lon1 = $4
}
NR == 3 {
    lat2 = $3
    lon2 = $4
}
END {
    pusat_lat = (lat1 + lat2) / 2
    pusat_lon = (lon1 + lon2) / 2
    printf "Koordinat pusat:\n%.6f, %.6f\n", pusat_lat, pusat_lon
}
' "$input" > "$output"

cat "$output"