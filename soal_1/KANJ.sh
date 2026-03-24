#!/bin/bash

BEGIN {
    FS = ","
    opsi = ARGV[2] # ambil opsi soal a/b/c/d/e dari argumen kedua

    if (opsi != "a" && opsi != "b" && opsi != "c" && opsi != "d" && opsi != "e") {
        print ("Soal tidak dikenali. Gunakan a, b, c, d, atau e.")
        print ("Contoh penggunaan: awk -f file.sh data.csv a")
        exit 1
    }
    
    # delete argumen kedua agar awk tidak menganggap argv2 sebagai file
    delete ARGV[2]
    umur_max = 0
}

# NR buat ignore header atau baris pertama CSV
NR > 1 {
    gsub(/\r/, "", $0) # hapus \r (enter) jadi string kosong 

    jml_penumpang++
    
    gerbong_unik[$4] = 1 # gerbong unik
    
    if ($2 > umur_max) {
        umur_max = $2
        tuwir = $1
    }
    
    total_umur += $2
    
    if ($3 == "Business") {
        konglomerat++
    }
}

END {
    if (opsi == "a") {
        print ("Jumlah seluruh penumpang KANJ adalah " jml_penumpang " orang")
    } 
    else if (opsi == "b") {
        jml_gerbong = 0
        for (i in gerbong_unik) jml_gerbong++
        print ("Jumlah gerbong penumpang KANJ adalah " jml_gerbong)
    } 
    else if (opsi == "c") {
        print (tuwir " adalah penumpang kereta tertua dengan usia " umur_max " tahun")
    } 
    else if (opsi == "d") {
        # sprintf "%.0f" dipakai untuk membulatkan tanpa angka di belakang koma
        print ("Rata-rata usia penumpang adalah " sprintf("%.0f", total_umur / jml_penumpang) " tahun")
    } 
    else if (opsi == "e") {
        print ("Jumlah penumpang business class ada " konglomerat " orang")
    }
}
