#!/bin/bash

# buat aktifin alternate screen, biar cakep aja
tput smcup

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

            while true; do
                read -p "Masukkan Nama: " nama
                if [[ -z "$nama" ]]; then
                    echo ">>> Error: Nama tidak boleh kosong!"
                else
                    break
                fi
            done

            # REVISI LAGEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
            while true; do
                read -p "Masukkan Nomor Kamar: " kamar
                if [[ ! "$kamar" =~ ^[0-9]+$ ]]; then
                    echo ">>> Error: Nomor kamar sudah diambil!"
                else
                    break
                fi
            done

            while true; do
                read -p "Masukkan Harga Sewa: " harga
                if [[ ! "$harga" =~ ^[0-9]+$ ]] then
                    echo ">>> Error: Harga harus berupa bilangan positif!"
                else
                    break
                fi
            done

            while true; do
                read -p "Masukkan Tanggal Masuk (YYYY-MM-DD): " tanggal

                hari_ini=$(date +%Y-%m-%d)
                
                if [[ ! "$tanggal" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
                    echo ">>> Error: Format salah! Gunakan format YYYY-MM-DD."
                else if ! date -d "$tanggal" &>/dev/null; then
                    echo ">>> Error: Tanggal '$tanggal' tidak ada di kalender!"
                else if [[ "$tanggal" > "$hari_ini" ]]; then
                    echo ">>> Error: Tanggal tidak valid! Maksimal adalah hari ini ($hari_ini)."
                else
                    break
                fi
            done

            while true; do
                read -p "Masukkan Status Awal (Aktif/Menunggak): " status
                if [[ ! "$status" =~ ^(Aktif|Menunggak|aktif|menunggak)$ ]]; then
                    echo ">>> Error: Status hanya boleh diisi 'Aktif' atau 'Menunggak'!"
                else
                    if [[ "$status" == "aktif" || "$status" == "Aktif" ]]; then
                        status="Aktif"
                    else
                        status="Menunggak"
                    fi
                    break
                fi
            done
        ;;
        2) echo "test2";;
        3) echo "test";;
        4) echo "test";;
        5) echo "test";;
        6) echo "test";;
        7) break;;
    esac
done