#!/bin/bash

grep -E '"id"|"site_name"|"latitude"|"longitude"' gsxtrack.json | \
sed -e 's/^[ \t]*//' -e 's/[",]//g' | \
awk -F': ' '{
    if (NR % 4 == 1) printf "%s,", $2   # cetak dengan koma
    if (NR % 4 == 2) printf "%s,", $2
    if (NR % 4 == 3) printf "%s,", $2
    if (NR % 4 == 0) print $2   # baris baru
}' >> titik-penting.txt