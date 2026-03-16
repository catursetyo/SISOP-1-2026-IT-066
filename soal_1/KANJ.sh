awk '{FS=","} $1 {++n} END {print "Jumlah seluruh penumpang KANJ adalah", n,"orang"}' passenger.csv
