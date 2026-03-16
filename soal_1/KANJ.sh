#!/bin/bash

BEGIN {
    FS = ","
    opsi = ARGV[2] # ambil opsi soal a/b/c/d/e dari argumen kedua

    if (opsi != "a" && opsi != "b" && opsi != "c" && opsi != "d" && opsi != "e") {
        print ("Soal tidak dikenali. Gunakan a, b, c, d, atau e.")
        print ("Contoh penggunaan: awk -f file.sh data.csv a")
        exit_flag = 1 # mencegah user salah input opsi
        exit 1
    }
    
    # delete argumen kedua agar awk tidak menganggap argv2 sebagai file
    delete ARGV[2]
    max_age = 0
}

# NR buat ignore header atau baris pertama CSV
NR > 1 && !exit_flag {
    count_passenger++
    
    carriage[$4] = 1 # gerbong unik
    
    if ($2 > max_age) {
        max_age = $2
        oldest = $1
    }
    
    total_age += $2
    
    if ($3 == "Business") {
        business_passenger++
    }
}

END {
    # jika terdapat error
    if (exit_flag) exit
    
    if (opsi == "a") {
        print ("Jumlah seluruh penumpang KANJ adalah " count_passenger " orang")
    } 
    else if (opsi == "b") {
        total_carriage = 0
        for (i in carriage) total_carriage++
        print ("Jumlah gerbong penumpang KANJ adalah " total_carriage)
    } 
    else if (opsi == "c") {
        print (oldest " adalah penumpang kereta tertua dengan usia " max_age " tahun")
    } 
    else if (opsi == "d") {
        # sprintf "%.0f" dipakai untuk membulatkan tanpa angka di belakang koma
        print ("Rata-rata usia penumpang adalah " sprintf("%.0f", total_age / count_passenger) " tahun")
    } 
    else if (opsi == "e") {
        # +0 agar mencetak angka 0 jika tidak ada penumpang business sama sekali
        print "Jumlah penumpang business class ada " (business_passenger + 0) " orang"
    }
}
