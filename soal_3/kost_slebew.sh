#!/bin/bash

# buat aktifin alternate screen, biar cakep aja
tput smcup

cleanup() {
    tput rmcup
    exit 0
}

trap cleanup EXIT SIGINT

DATA_FILE="data/penghuni.csv"
LOG_FILE="log/tagihan.log"
REKAP_FILE="rekap/laporan_bulanan.txt"
SAMPAH_FILE="sampah/history_hapus.csv"

SCRIPT_PATH="$(cd "$(dirname "$0")" && pwd)/$(basename "$0")"

# inisiasi directory dan file
init_storage() {
    mkdir -p "data" "log" "rekap" "sampah"

    [[ -f "$DATA_FILE" ]] || echo "Nama,No_Kamar,Harga_Sewa,Tanggal_Masuk,Status" > "$DATA_FILE"
    [[ -f "$LOG_FILE" ]] || : > "$LOG_FILE"
    [[ -f "$REKAP_FILE" ]] || : > "$REKAP_FILE"
    [[ -f "$SAMPAH_FILE" ]] || echo "Nama,No_Kamar,Harga_Sewa,Tanggal_Masuk,Status,Tanggal_Hapus" > "$SAMPAH_FILE"
}

pause() {
    echo
    read -r -p "Tekan [ENTER] untuk kembali ke menu..." _
}

# normalisasi case sensitive 'Aktif' dan 'Menunggak'
normalize_status() {
    local input
    input=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    case "$input" in
        aktif) echo "Aktif" ;;
        menunggak) echo "Menunggak" ;;
        *) echo "" ;;
    esac
}

# ubah angka jadi format rupiah
format_rupiah() {
    local number="$1"
    if [[ -z "$number" || ! "$number" =~ ^[0-9]+$ ]]; then
        echo "Rp0"
        return
    fi

    local rev formatted=""
    rev=$(echo "$number" | rev)
    while [[ -n "$rev" ]]; do
        formatted+="${rev:0:3}."
        rev="${rev:3}"
    done
    formatted="${formatted%.}"
    echo "Rp$(echo "$formatted" | rev)"
}

check_tagihan() {
    init_storage
    local now
    now=$(date '+%Y-%m-%d %H:%M:%S')

    awk -F',' -v now="$now" 'NR > 1 && tolower($5) == "menunggak" {
        printf "[%s] TAGIHAN: %s (Kamar %s) - Menunggak Rp%s\n", now, $1, $2, $3
    }' "$DATA_FILE" >> "$LOG_FILE"
}

main_menu() {
    clear
    echo "
 █████╗ ███╗   ███╗██████╗  █████╗ ████████╗██╗   ██╗██╗  ██╗ ██████╗ ███████╗████████╗
██╔══██╗████╗ ████║██╔══██╗██╔══██╗╚══██╔══╝██║   ██║██║ ██╔╝██╔═══██╗██╔════╝╚══██╔══╝
███████║██╔████╔██║██████╔╝███████║   ██║   ██║   ██║█████╔╝ ██║   ██║███████╗   ██║
██╔══██║██║╚██╔╝██║██╔══██╗██╔══██║   ██║   ██║   ██║██╔═██╗ ██║   ██║╚════██║   ██║
██║  ██║██║ ╚═╝ ██║██████╔╝██║  ██║   ██║   ╚██████╔╝██║  ██╗╚██████╔╝███████║   ██║
╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝
"
    echo "=============================================="
    echo "         SISTEM MANAJEMEN AMBATUKOST"
    echo "=============================================="
    echo "ID | OPTIONS"
    echo "----------------------------------------------"
    echo " 1 | Tambah Penghuni Baru"
    echo " 2 | Hapus Penghuni"
    echo " 3 | Tampilkan Daftar Penghuni"
    echo " 4 | Update Status Penghuni"
    echo " 5 | Cetak Laporan Keuangan"
    echo " 6 | Kelola Cron (Pengingat Tagihan)"
    echo " 7 | Exit Program"
    echo "=============================================="
}

tambah_penghuni() {
    clear
    echo "=============================================="
    echo "               TAMBAH PENGHUNI                "
    echo "=============================================="

    local nama kamar harga tanggal status hari_ini

    while true; do
        read -r -p "Masukkan Nama: " nama
        if [[ -z "$nama" ]]; then
            echo ">>> Error: Nama tidak boleh kosong!"
        else
            break
        fi
    done

    while true; do
        read -r -p "Masukkan Kamar: " kamar
        if [[ ! "$kamar" =~ ^[0-9]+$ ]]; then
            echo ">>> Error: Nomor kamar harus berupa angka positif!"
            continue
        fi

        if awk -F',' -v kamar="$kamar" 'NR > 1 && $2 == kamar {exit 0} END {exit 1}' "$DATA_FILE"; then
            echo ">>> Error: Kamar $kamar sudah ditempati!"
            continue
        fi
        break
    done

    while true; do
        read -r -p "Masukkan Harga Sewa: " harga
        if [[ ! "$harga" =~ ^[1-9][0-9]*$ ]]; then
            echo ">>> Error: Harga sewa harus berupa angka positif!"
        else
            break
        fi
    done

    while true; do
        read -r -p "Masukkan Tanggal Masuk (YYYY-MM-DD): " tanggal
        hari_ini=$(date +%Y-%m-%d)

        if [[ ! "$tanggal" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
            echo ">>> Error: Format tanggal harus YYYY-MM-DD!"
        elif ! date -d "$tanggal" >/dev/null 2>&1; then
            echo ">>> Error: Tanggal tidak valid!"
        elif [[ "$tanggal" > "$hari_ini" ]]; then
            echo ">>> Error: Tanggal tidak boleh melebihi hari ini ($hari_ini)!"
        else
            break
        fi
    done

    while true; do
        read -r -p "Masukkan Status Awal (Aktif/Menunggak): " status
        status=$(normalize_status "$status")
        if [[ -z "$status" ]]; then
            echo ">>> Error: Status hanya boleh Aktif atau Menunggak!"
        else
            break
        fi
    done

    printf '%s,%s,%s,%s,%s\n' "$nama" "$kamar" "$harga" "$tanggal" "$status" >> "$DATA_FILE"

    echo
    echo "[✓] Penghuni \"$nama\" berhasil ditambahkan ke Kamar $kamar dengan status $status."
    pause
}

hapus_penghuni() {
    clear
    echo "=============================================="
    echo "                HAPUS PENGHUNI                "
    echo "=============================================="

    local nama hapus_tanggal row
    read -r -p "Masukkan nama penghuni yang akan dihapus: " nama

    if [[ -z "$nama" ]]; then
        echo ">>> Error: Nama tidak boleh kosong!"
        pause
        return
    fi

    row=$(awk -F',' -v nama="$nama" 'NR > 1 && tolower($1) == tolower(nama) {print $0; exit}' "$DATA_FILE")
    if [[ -z "$row" ]]; then
        echo ">>> Error: Penghuni dengan nama \"$nama\" tidak ditemukan."
        pause
        return
    fi

    hapus_tanggal=$(date +%Y-%m-%d)
    echo "$row,$hapus_tanggal" >> "$SAMPAH_FILE"

    awk -F',' -v nama="$nama" 'BEGIN {OFS=FS}
        NR == 1 {print; next}
        tolower($1) == tolower(nama) && found == 0 {found=1; next}
        {print}
    ' "$DATA_FILE" > "$DATA_FILE.tmp" && mv "$DATA_FILE.tmp" "$DATA_FILE"

    echo
    echo "[✓] Data penghuni \"$nama\" berhasil diarsipkan ke $SAMPAH_FILE dan dihapus dari sistem."
    pause
}

tampilkan_daftar_penghuni() {
    clear
    echo "=============================================================="
    echo "               DAFTAR PENGHUNI KOST SLEBEW                    "
    echo "=============================================================="

    if [[ $(wc -l < "$DATA_FILE") -le 1 ]]; then
        echo "Belum ada data penghuni."
        pause
        return
    fi

    awk -F',' '
        BEGIN {
            printf "%-3s | %-20s | %-5s | %-15s | %-10s\n", "No", "Nama", "Kamar", "Harga Sewa", "Status"
            print "---------------------------------------------------------------------"
        }
        NR > 1 {
            no++
            aktif += (tolower($5) == "aktif")
            menunggak += (tolower($5) == "menunggak")
            harga = $3
            gsub(/[^0-9]/, "", harga)
            printf "%-3d | %-20s | %-5s | %-15s | %-10s\n", no, $1, $2, "Rp" harga, $5
        }
        END {
            print "---------------------------------------------------------------------"
            printf "Total: %d penghuni | Aktif: %d | Menunggak: %d\n", no, aktif, menunggak
        }
    ' "$DATA_FILE"

    pause
}

update_status_penghuni() {
    clear
    echo "=============================================="
    echo "                UPDATE STATUS                 "
    echo "=============================================="

    local nama status_baru
    read -r -p "Masukkan Nama Penghuni: " nama

    if [[ -z "$nama" ]]; then
        echo ">>> Error: Nama tidak boleh kosong!"
        pause
        return
    fi

    if ! awk -F',' -v nama="$nama" 'NR > 1 && tolower($1) == tolower(nama) {exit 0} END {exit 1}' "$DATA_FILE"; then
        echo ">>> Error: Penghuni dengan nama \"$nama\" tidak ditemukan."
        pause
        return
    fi

    while true; do
        read -r -p "Masukkan Status Baru (Aktif/Menunggak): " status_baru
        status_baru=$(normalize_status "$status_baru")
        if [[ -z "$status_baru" ]]; then
            echo ">>> Error: Status hanya boleh Aktif atau Menunggak!"
        else
            break
        fi
    done

    awk -F',' -v nama="$nama" -v status_baru="$status_baru" 'BEGIN {OFS=FS}
        NR == 1 {print; next}
        tolower($1) == tolower(nama) {$5 = status_baru}
        {print}
    ' "$DATA_FILE" > "$DATA_FILE.tmp" && mv "$DATA_FILE.tmp" "$DATA_FILE"

    echo
    echo "[✓] Status penghuni \"$nama\" berhasil diubah menjadi: $status_baru"
    pause
}

cetak_laporan_keuangan() {
    clear
    echo "=============================================================="
    echo "               LAPORAN KEUANGAN KOST SLEBEW                  "
    echo "=============================================================="

    local total_aktif total_tunggakan jumlah_kamar daftar_tunggakan harga_raw prefix

    total_aktif=$(awk -F',' 'NR > 1 && tolower($5) == "aktif" {sum += $3} END {print sum + 0}' "$DATA_FILE")
    total_tunggakan=$(awk -F',' 'NR > 1 && tolower($5) == "menunggak" {sum += $3} END {print sum + 0}' "$DATA_FILE")
    jumlah_kamar=$(awk -F',' 'NR > 1 {count++} END {print count + 0}' "$DATA_FILE")
    daftar_tunggakan=$(awk -F',' 'NR > 1 && tolower($5) == "menunggak" {printf "- %s (Kamar %s): %s\n", $1, $2, $3}' "$DATA_FILE")

    {
        echo "=============================================================="
        echo "               LAPORAN KEUANGAN KOST SLEBEW                  "
        echo "=============================================================="
        echo "Total pemasukan (Aktif) : $(format_rupiah "$total_aktif")"
        echo "Total tunggakan         : $(format_rupiah "$total_tunggakan")"
        echo "Jumlah kamar terisi     : $jumlah_kamar"
        echo "--------------------------------------------------------------"
        echo "Daftar penghuni menunggak:"
        if [[ -n "$daftar_tunggakan" ]]; then
            while IFS= read -r line; do
                harga_raw=$(echo "$line" | awk -F': ' '{print $2}')
                prefix=$(echo "$line" | awk -F': ' '{print $1}')
                echo "$prefix: $(format_rupiah "$harga_raw")"
            done <<< "$daftar_tunggakan"
        else
            echo "Tidak ada tunggakan."
        fi
        echo "=============================================================="
    } | tee "$REKAP_FILE"

    echo
    echo "[✓] Laporan berhasil disimpan ke $REKAP_FILE"
    pause
}

lihat_cron_aktif() {
    clear
    echo "=============================================="
    echo "            DAFTAR CRON JOB AKTIF            "
    echo "=============================================="

    local jobs
    jobs=$(crontab -l 2>/dev/null | grep -F "$SCRIPT_PATH --check-tagihan")

    if [[ -z "$jobs" ]]; then
        echo "Belum ada cron job pengingat tagihan yang aktif."
    else
        echo "$jobs"
    fi
    pause
}

daftarkan_cron() {
    clear
    echo "=============================================="
    echo "         DAFTARKAN CRON JOB PENGINGAT         "
    echo "=============================================="

    local jam menit cron_line temp_file

    while true; do
        read -r -p "Masukkan Jam (0-23) [default 07]: " jam
        jam=${jam:-07}
        if [[ "$jam" =~ ^([0-9]|0[0-9]|1[0-9]|2[0-3])$ ]]; then
            jam=$(printf '%02d' "$jam")
            break
        else
            echo ">>> Error: Jam harus berada pada rentang 0-23."
        fi
    done

    while true; do
        read -r -p "Masukkan Menit (0-59) [default 00]: " menit
        menit=${menit:-00}
        if [[ "$menit" =~ ^([0-9]|0[0-9]|[1-5][0-9])$ ]]; then
            menit=$(printf '%02d' "$menit")
            break
        else
            echo ">>> Error: Menit harus berada pada rentang 0-59."
        fi
    done

    cron_line="$menit $jam * * * $SCRIPT_PATH --check-tagihan"
    temp_file=$(mktemp)
    crontab -l 2>/dev/null | grep -v -F "$SCRIPT_PATH --check-tagihan" > "$temp_file" || true
    echo "$cron_line" >> "$temp_file"
    crontab "$temp_file"
    rm -f "$temp_file"

    echo
    echo "[✓] Cron job pengingat tagihan berhasil didaftarkan."
    echo "$cron_line"
    pause
}

hapus_cron() {
    clear
    echo "=============================================="
    echo "          HAPUS CRON JOB PENGINGAT            "
    echo "=============================================="

    local temp_file existing
    existing=$(crontab -l 2>/dev/null | grep -F "$SCRIPT_PATH --check-tagihan")

    if [[ -z "$existing" ]]; then
        echo "Tidak ada cron job pengingat yang perlu dihapus."
        pause
        return
    fi

    temp_file=$(mktemp)
    crontab -l 2>/dev/null | grep -v -F "$SCRIPT_PATH --check-tagihan" > "$temp_file" || true
    crontab "$temp_file"
    rm -f "$temp_file"

    echo "[✓] Cron job pengingat tagihan berhasil dihapus."
    pause
}

kelola_cron() {
    local pilih
    while true; do
        clear
echo "=================================="
echo "         MENU KELOLA CRON"
echo "=================================="
echo "1. Lihat Cron Job Aktif"
echo "2. Daftarkan Cron Job Pengingat"
echo "3. Hapus Cron Job Pengingat"
echo "4. Kembali"
echo "=================================="

        read -r -p "Pilih [1-4]: " pilih
        case "$pilih" in
            1) lihat_cron_aktif ;;
            2) daftarkan_cron ;;
            3) hapus_cron ;;
            4) break ;;
            *) echo ">>> Error: Pilihan tidak valid!"; pause ;;
        esac
    done
}

main() {
    init_storage

    while true; do
        main_menu
        read -r -p "Enter option [1-7]: " opsi

        case "$opsi" in
            1) tambah_penghuni ;;
            2) hapus_penghuni ;;
            3) tampilkan_daftar_penghuni ;;
            4) update_status_penghuni ;;
            5) cetak_laporan_keuangan ;;
            6) kelola_cron ;;
            7) echo "Terima kasih. Program selesai."; break ;;
            *) echo ">>> Error: Pilihan tidak valid!"; pause ;;
        esac
    done
}

if [[ "$1" == "--check-tagihan" ]]; then
    check_tagihan
    exit 0
fi

main