#!/bin/bash

echo "
 █████╗ ███╗   ███╗██████╗  █████╗ ████████╗██╗   ██╗██╗  ██╗ ██████╗ ███████╗████████╗
██╔══██╗████╗ ████║██╔══██╗██╔══██╗╚══██╔══╝██║   ██║██║ ██╔╝██╔═══██╗██╔════╝╚══██╔══╝
███████║██╔████╔██║██████╔╝███████║   ██║   ██║   ██║█████╔╝ ██║   ██║███████╗   ██║   
██╔══██║██║╚██╔╝██║██╔══██╗██╔══██║   ██║   ██║   ██║██╔═██╗ ██║   ██║╚════██║   ██║   
██║  ██║██║ ╚═╝ ██║██████╔╝██║  ██║   ██║   ╚██████╔╝██║  ██╗╚██████╔╝███████║   ██║   
╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   
"

while true; do
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
        1) echo "test1";;
        2) echo "test2";;
        3) echo "test";;
        4) echo "test";;
        5) echo "test";;
        6) echo "test";;
        7) break;;
    esac
done