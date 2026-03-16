#!/bin/bash

tput smcup # buat aktifin alternate screen, biar cakep aja

# bersihin terminal pas keluar (ctrl + c)
cleanup() {
    # balik ke terminal awal
    tput rmcup
    exit 0
}

# jalanin fungsi cleanup() diatas
trap cleanup EXIT SIGINT

while true; do
    clear

    echo "
 █████╗ ███╗   ███╗██████╗  █████╗ ████████╗██╗   ██╗██╗  ██╗ ██████╗ ███████╗████████╗
██╔══██╗████╗ ████║██╔══██╗██╔══██╗╚══██╔══╝██║   ██║██║ ██╔╝██╔═══██╗██╔════╝╚══██╔══╝
███████║██╔████╔██║██████╔╝███████║   ██║   ██║   ██║█████╔╝ ██║   ██║███████╗   ██║   
██╔══██║██║╚██╔╝██║██╔══██╗██╔══██║   ██║   ██║   ██║██╔═██╗ ██║   ██║╚════██║   ██║   
██║  ██║██║ ╚═╝ ██║██████╔╝██║  ██║   ██║   ╚██████╔╝██║  ██╗╚██████╔╝███████║   ██║   
╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   
"

    echo "=========================================="
    echo "ID | OPTIONS"
    echo "------------------------------------------"
    echo "1 | Tambah Penghuni Baru"
    echo "2 | Hapus Penghuni"
    echo "3 | Tampilkan Daftar Penghuni"
    echo "4 | Update Status Penghuni"
    echo "5 | Cetak Laporan Keuangan"
    echo "6 | Kelola Cron (Pengingat Tagihan)"
    echo "7 | Exit Program"
    echo "=========================================="

    read -p "Enter option [1-7]: " opsi

    case $opsi in
        1)
            echo "=========================================="
            echo "             TAMBAH PENGHUNI              "
            echo "=========================================="

            read -p "Masukkan Nama: " nama
            read -p "Masukkan Kamar: " kamar
            read -p "Masukkan Harga Sewa: " harga
            read -p "Masukkan Tanggal Masuk (YYYY-MM-DD): " tanggal
            read -p "Masukkan Status Awal (Aktif/Menunggak): " status
        ;;
        2) echo "test2";;
        3) echo "test";;
        4) echo "test";;
        5) echo "test";;
        6) echo "test";;
        7) break;;
    esac
done