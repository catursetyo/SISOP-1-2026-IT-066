# Laporan Praktikum Modul 1 Sistem Operasi

**Nama:** Catur Setyo Ragil\
**NRP:** 5027251066\
**Kelas:** Sistem Operasi B\
**Kode Asisten:** SCRA

---

## Struktur Repository
```
.
├── soal_1/
│   ├── KANJ.sh
│   └── passenger.csv
├── soal_2/
│   └── ekspedisi/
│       ├── peta-ekspedisi-amba.pdf
│       └── peta-gunung-kawi/
│           ├── gsxtrack.json
│           ├── parserkoordinat.sh
│           ├── nemupusaka.sh
│           ├── titik-penting.txt
│           └── posisipusaka.txt
└── soal_3/
    ├── kost_slebew.sh
    ├── data/
    │   └── penghuni.csv
    ├── log/
    │   └── tagihan.log
    ├── rekap/
    │   └── laporan_bulanan.txt
    └── sampah/
        └── history_hapus.csv
```
> **Note:** Struktur di atas mengikuti format yang diminta pada soal. Namun untuk directory [/assets](https://github.com/catursetyo/SISOP-1-2026-IT-066/tree/main/assets) tidak termasuk ke dalam struktur repository, karena digunakan untuk keperluan laporan pada [README.md](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/README.md).

---

## Pembahasan Soal

## Soal 1: KERETA ARGO NGAWI JESGEJES

Pada soal nomor 1, diminta untuk membuat script bebasis AWK yang digunakan untuk membaca file [passenger.csv](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_1/passenger.csv) dan menghasilkan beberapa informasi mengenai penumpang berdasarkan opsi yang dipilih.

Seluruh interaksi pada soal 1 dapat dilakukan dengan mengeksekusi file [KANJ.sh](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_1/KANJ.sh) beserta opsi (a, b, c, d, atau e) yang dipilihnya, dengan keterangan:

- **a** → menghitung jumlah seluruh penumpang.
- **b** → menghitung jumlah gerbong unik yang digunakan.
- **c** → mencari penumpang tertua.
- **d** → menghitung rata-rata usia penumpang.
- **e** → menghitung jumlah penumpang kelas Business.

Selain itu, script juga memiliki validasi input agar hanya menerima opsi `a`, `b`, `c`, `d`, atau `e`.

Contoh penggunaan:
```bash
awk -f KANJ.sh passenger.csv a/b/c/d/e
```

### Sub-soal A
Pada soal ini, diminta untuk menghitung jumlah seluruh penumpang (tidak termasuk header).
```bash
NR > 1 && !exit_flag {
    count_passenger++
}
```
Perintah tersebut membaca baris per baris dari [passenger.csv](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_1/passenger.csv) dan menambah jumlah penumpang sesuai dengan jumlah baris yang dibaca, terkecuali header.
```bash
if (opsi == "a") {
    print ("Jumlah seluruh penumpang KANJ adalah " count_passenger " orang")
}
```
Hasil dari `count_passenger++` akan dimasukkan kedalam conditionals yang nantinya digunakan untuk menampilkan output.

#### Contoh output:
<img src="/assets/soal1-a.png">

### Sub-soal B
Pada soal ini, diminta untuk menghitung berapa banyak jumlah gerbong unik yang digunakan dalam perjalanan tersebut.
```bash
NR > 1 && !exit_flag {
    carriage[$4] = 1
}
```
Array `carriage[]` membaca baris dari gerbong, yaitu `$4`. Sehingga data dari gerbong gerbong tersebut dimasukkan ke dalam array dan diberikan nilai `= 1` sebagai penanda bahwa gerbong tersebut ada.
```bash
else if (opsi == "b") {
    total_carriage = 0
    for (i in carriage) total_carriage++
    print ("Jumlah gerbong penumpang KANJ adalah " total_carriage)
}
```
Key unik dari `carriage[$4]` dibaca pada loop tersebut dan digunakan untuk menghitung jumlah dari gerbong unik yang digunakan.

#### Contoh output:
<img src="/assets/soal1-b.png">

### Sub-soal C
Pada soal ini, diminta untuk mencari data penumpang dengan usia paling tua (nama dan usia).
```bash
max_age = 0

NR > 1 && !exit_flag {
    if ($2 > max_age) {
        max_age = $2
        oldest = $1
    }
}
```

`max_age` diinisiasi dengan nilai nol, yang akan digunakan sebagai pembanding untuk mencari usia tertinggi dari kolom `$2`. Nantinya `max_age` akan diupdate dengan nilai usia yang lebih tinggi, serta menyimpan nama penumpang tersebut yang ada di kolom `$1` pada variable `oldest`.

#### Contoh output:
<img src="/assets/soal1-c.png">

### Sub-soal D
Pada soal ini, diminta untuk menghitung rata-rata usia seluruh penumpang serta memberikan output tanpa angka di belakang koma.
```bash
NR > 1 && !exit_flag {
    total_age += $2
}
```

`total_age` menghitung jumlah usia seluruh penumpang yang ada pada kolom `$2` setiap kali AWK membaca tiap baris.

```bash
else if (opsi == "d") {
    print ("Rata-rata usia penumpang adalah " sprintf("%.0f", total_age / count_passenger) " tahun")
    }
```
Output kemudian dibulatkan agar tidak memiliki angka dibelakang koma menggunakan `sprintf(%.0f)`.

#### Contoh output:
<img src="/assets/soal1-d.png">

### Sub-soal E
Pada soal ini, diminta untuk menghitung jumlah penumpang yang memilih Business Class.
```bash
NR > 1 && !exit_flag {
    if ($3 == "Business") {
        business_passenger++
    }
}
```
Pada kolom gerbong `$3`, apabila penumpang memilih Business Class, maka nilai dari `business_passenger` akan bertambah 1 setiap penumpang.

#### Contoh output:
<img src="/assets/soal1-e.png">

Sehingga, berdasarkan data dari [passenger.csv](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_1/passenger.csv), script [KANJ.sh](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_1/KANJ.sh) menghasilkan output:

- Total penumpang: **208 orang**
- Jumlah gerbong: **4**
- Penumpang tertua: **Jaja Mihardja (85 tahun)**
- Rata-rata usia: **38 tahun**
- Penumpang Business class: **74 orang**

## Soal 2: EKSPEDISI PESUGIHAN GUNUNG KAWI - MAS AMBA

Pada soal ini, diminta untuk mengekstrak data koordinat dari file [gsxtrack.json](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_2/ekspedisi/peta-gunung-kawi/gsxtrack.json), menyusunnya ke file [titik-penting.txt](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_2/ekspedisi/peta-gunung-kawi/titik-penting.txt), lalu menghitung koordinat pusat untuk memperoleh lokasi pusaka dan menyimpannya pada file [posisipusaka.txt](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_2/ekspedisi/peta-gunung-kawi/posisipusaka.txt).

Pada langkah pertama, diminta untuk mendownload file [peta-ekspedisi-amba.pdf](https://drive.google.com/uc?id=1q10pHSC3KFfvEiCN3V6PTroPR7YGHF6Q) menggunakan `gdown`.

Meskipun saya tidak tau mengapa harus menggunakan `gdown` padahal terdapat alternatif lain. Untuk menginstall `gdown` dapat dilakukan dengan menginisiasi python venv.
```bash
python3 -m venv env
source env/bin/activate
pip install gdown
```

Lalu dapat langsung menggunakan `gdown` untuk mendownload file tersebut dan langsung simpan ke directory [/ekspedisi](https://github.com/catursetyo/SISOP-1-2026-IT-066/tree/main/soal_2/ekspedisi).
```bash
gdown 'https://drive.google.com/uc?id=1q10pHSC3KFfvEiCN3V6PTroPR7YGHF6Q'
mv peta-ekspedisi-amba.pdf /soal_2/ekspedisi
```

Kemudian, file [peta-ekspedisi-amba.pdf](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_2/ekspedisi/peta-ekspedisi-amba.pdf) dapat dilihat menggunakan `cat` ataupun `strings` untuk melihat maksud tersembunyi dari probset.
```bash
cat peta-ekspedisi-amba.pdf
# atau
strings peta-ekspedisi-amba.pdf
```

Sehingga akan mendapatkan:\
<img src="/assets/soal2-a.png">

Setelah mendapatkan link github repo, kita dapat melakukan `clone` pada repository tersebut.
```bash
git clone https://github.com/pocongcyber77/peta-gunung-kawi.git
```

Repo tersebut berisikan file [gsxtrack.json](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_2/ekspedisi/peta-gunung-kawi/gsxtrack.json), file tersebut berisikan beberapa titik lokasi dengan informasi `site_name`,`latitude (x)`, `longitude (y)`, dll.

Setelah itu, diperlukan sebuah script [parserkoordinat.sh](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_2/ekspedisi/peta-gunung-kawi/parserkoordinat.sh) yang menggunakan `regex` untuk mengekstrak data dari [gsxtrack.json](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_2/ekspedisi/peta-gunung-kawi/gsxtrack.json) ke [titik-penting.txt](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_2/ekspedisi/peta-gunung-kawi/titik-penting.txt).

```bash
#!/bin/bash

grep -E '"id"|"site_name"|"latitude"|"longitude"' gsxtrack.json | \
sed -e 's/^[ \t]*//' -e 's/[",]//g' | \
awk -F': ' '{
    if (NR % 4 == 1) printf "%s,", $2
    if (NR % 4 == 2) printf "%s,", $2
    if (NR % 4 == 3) printf "%s,", $2
    if (NR % 4 == 0) print $2
}' > titik-penting.txt
```

`grep` digunakan agar script hanya mengambil 4 elemen penting dari [gsxtrack.json](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_2/ekspedisi/peta-gunung-kawi/gsxtrack.json), yaitu `id`, `site_name`, `latitude`, dan `longitude`.

`sed` digunakan untuk membersihkan hasil `grep`.
```
s/^[ \t]*//
```
Digunakan untuk membersihkan spasi/tab di awal baris
```
s/[",]//g
```
Untuk menghapus semua tanda kutip `"` dan koma `,`

Lalu dilanjutkan menggunakan `awk` untuk mencetak hasil dari `grep` dan `sed` serta memasukkannya ke dalam [titik-penting.txt](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_2/ekspedisi/peta-gunung-kawi/titik-penting.txt).

Sehingga output dari [titik-penting.txt](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_2/ekspedisi/peta-gunung-kawi/titik-penting.txt) yang dihasilkan adalah:
```
node_001,Titik Berak Paman Mas Mba,-7.920000,112.450000
node_002,Basecamp Mas Fuad,-7.920000,112.468100
node_003,Gerbang Dimensi Keputih,-7.937960,112.468100
node_004,Tembok Ratapan Keputih,-7.937960,112.450000
```

Setelah mendapatkan [titik-penting.txt](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_2/ekspedisi/peta-gunung-kawi/titik-penting.txt), sekarang diminta untuk menghitung titik tengah diagonal menggunakan rumus titik tengah persegi.

$$
(\frac{x1+x2}{2}, \frac{y1+y2}{2})
$$

Script [nemupusaka.sh](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_2/ekspedisi/peta-gunung-kawi/nemupusaka.sh) akan mengambil input `latitude` dan `longitude` dari [titik-penting.txt](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_2/ekspedisi/peta-gunung-kawi/titik-penting.txt).
```bash
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
```

Diambil titik pertama dan juga ketiga sebagai dua titik diagonal, masing-masing `latitude` dan `longitude` dari kedua titik tersebut dijumlahkan lalu dibagi dengan `2`. Sehingga menghasilkan titik pusat yang disimpan pada file [posisipusaka.txt](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_2/ekspedisi/peta-gunung-kawi/posisipusaka.txt).

Dengan titik pusat yang dihasilkan adalah sebagai berikut:

<img src="/assets/soal2-b.png">

## Soal 3: KOST SLEBEW AMBATUKAM

Pada soal ini, diminta untuk membangun aplikasi CLI interaktif berbasis Bash untuk mengelola data penghuni kost, termasuk tambah/hapus data, menampilkan daftar penghuni, mengubah status pembayaran, mencetak laporan keuangan, dan mengelola cron job pengingat tagihan.

<img src="/assets/soal3-a.png">

> **Note:** Dikarenakan adanya kebebasan artistik, maka dilakukan beberapa penyesuaian untuk tampilan akhir dari program [kost_slebew.sh](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_3/kost_slebew.sh).

```bash
tput smcup

cleanup() {
    tput rmcup
    exit 0
}

trap cleanup EXIT SIGINT
```

Digunakan untuk menampilkan program [kost_slebew.sh](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_3/kost_slebew.sh) dalam alternate screen, sehingga tampilan dari program tersebut terlihat lebih rapi.

### Inisialisasi Database

Karena program ini mengharuskan data penghuni tersimpan dalam database lokal, maka diperlukan inisialisasi file dan directory untuk databasenya.

```bash
DATA_FILE="data/penghuni.csv"
LOG_FILE="log/tagihan.log"
REKAP_FILE="rekap/laporan_bulanan.txt"
SAMPAH_FILE="sampah/history_hapus.csv"

SCRIPT_PATH="$(cd "$(dirname "$0")" && pwd)/$(basename "$0")"

init_storage() {
    mkdir -p "data" "log" "rekap" "sampah"

    [[ -f "$DATA_FILE" ]] || echo "Nama,No_Kamar,Harga_Sewa,Tanggal_Masuk,Status" > "$DATA_FILE"
    [[ -f "$LOG_FILE" ]] || : > "$LOG_FILE"
    [[ -f "$REKAP_FILE" ]] || : > "$REKAP_FILE"
    [[ -f "$SAMPAH_FILE" ]] || echo "Nama,No_Kamar,Harga_Sewa,Tanggal_Masuk,Status,Tanggal_Hapus" > "$SAMPAH_FILE"
}
```

Pada program ini, [penghuni.csv](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_3/data/penghuni.csv) digunakan sebagai database utama yang menyimpan data penghuni saat ini.

`SCRIPT_PATH` sebagai path absolute yang akan membantu cron job mendapatkan path dari [kost_slebew.sh](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_3/kost_slebew.sh).

### Implementasi Fitur

Terdapat beberapa fitur yang harus diimplementasikan ke dalam program [kost_slebew.sh](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_3/kost_slebew.sh), diantara lain:

### 1. Tambah Penghuni Baru

Pada fitur ini, terdapat beberapa rules yang harus diterapkan pada program, yaitu:

 - Input: nama, nomor kamar, harga sewa, tanggal masuk, status.
 - Validasi: nomor kamar harus unik (tidak boleh bentrok), harga harus positif, tanggal valid dan tidak melebihi hari ini, status harus `Aktif` atau `Menunggak`.

Lalu saya menambahkan validasi untuk input field tidak boleh kosong.

```bash
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

        if awk -F',' -v kamar="$kamar" 'NR > 1 && $2 == kamar {dipake=1} END {exit !dipake}' "$DATA_FILE"; then
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
```

`local variable` dideklarasikan pada awal fungsi, seluruh input field dari fungsi tersebut dimasukkan ke dalam infinite loop yang akan terus berulang sampai user memasukkan format input yang tepat.

```bash
while true; do
    read -r -p "Masukkan Nama: " nama
    if [[ -z "$nama" ]]; then
        echo ">>> Error: Nama tidak boleh kosong!"
    else
        break
    fi
done
```

Pada bagian `nama`, user dapat menginput nilai/karakter apapun asalkan tidak kosong.

```bash
while true; do
    read -r -p "Masukkan Kamar: " kamar
    if [[ ! "$kamar" =~ ^[0-9]+$ ]]; then
        echo ">>> Error: Nomor kamar harus berupa angka positif!"
        continue
    fi

    if awk -F',' -v kamar="$kamar" 'NR > 1 && $2 == kamar {dipake=1} END {exit !dipake}' "$DATA_FILE"; then
        echo ">>> Error: Kamar $kamar sudah ditempati!"
        continue
    fi
    break
done
```

User hanya dapat menginput nomor kamar berupa angka positif. Setelah itu, nomor kamar divalidasi menggunakan `awk` dengan memeriksa kolom kedua pada file [penghuni.csv]((https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_3/data/penghuni.csv)). Jika nomor kamar ditemukan, maka variabel `dipake` akan diaktifkan, sehingga `awk` memberikan feedback berupa exit status `0`, sehingga pesan error akan muncul.

<img src="/assets/soal3-b.png">

```bash
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
```

Variable `hari_ini` diisi dengan tanggal sistem saat ini, lalu dilakukan validasi format tanggal (YYYY-MM-DD). Apabila format tanggal benar, akan divalidasi kembali apakah tanggal tersebut valid, `date` akan membaca string tanggal dari variable `$tanggal`.

Tanggal yang diinput juga tidak boleh melebihi tanggal sistem saat ini.

<img src="/assets/soal3-c.png">

```bash
while true; do
    read -r -p "Masukkan Status Awal (Aktif/Menunggak): " status
    status=$(normalize_status "$status")
    if [[ -z "$status" ]]; then
        echo ">>> Error: Status hanya boleh Aktif atau Menunggak!"
    else
        break
    fi
done
```

Pada `status`, user diminta untuk menginput status penghuni (aktif/menunggak), karena bersifat `case-sensitive` input user akan dinormalisasi menggunakan fungsi `normalize_status()`.

```bash
normalize_status() {
    local input
    input=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    case "$input" in
        aktif) echo "Aktif" ;;
        menunggak) echo "Menunggak" ;;
        *) echo "" ;;
    esac
}
```

### 2. Hapus Penghuni

```bash
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
```

### 3. Tampilkan Daftar Penghuni

```bash
tampilkan_daftar_penghuni() {
    clear
    echo "=============================================================="
    echo "                  DAFTAR PENGHUNI AMBATUKOST                  "
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
```

### 4. Update Status Penghuni

```bash
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
```

### 5. Cetak Laporan Keuangan

```bash
cetak_laporan_keuangan() {
    clear
    echo "=============================================================="
    echo "                 LAPORAN KEUANGAN AMBATUKOST                  "
    echo "=============================================================="

    local total_aktif total_tunggakan jumlah_kamar daftar_tunggakan harga_raw prefix

    total_aktif=$(awk -F',' 'NR > 1 && tolower($5) == "aktif" {sum += $3} END {print sum + 0}' "$DATA_FILE")
    total_tunggakan=$(awk -F',' 'NR > 1 && tolower($5) == "menunggak" {sum += $3} END {print sum + 0}' "$DATA_FILE")
    jumlah_kamar=$(awk -F',' 'NR > 1 {count++} END {print count + 0}' "$DATA_FILE")
    daftar_tunggakan=$(awk -F',' 'NR > 1 && tolower($5) == "menunggak" {printf "- %s (Kamar %s): %s\n", $1, $2, $3}' "$DATA_FILE")

    {
        echo "=============================================================="
        echo "                 LAPORAN KEUANGAN AMBATUKOST                  "
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
```

### 6. Kelola Cron

```bash
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
```

```bash
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
```bash
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
```

```bash
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
```

### 7. Cek Tagihan

```bash
check_tagihan() {
    init_storage
    local now
    now=$(date '+%Y-%m-%d %H:%M:%S')

    awk -F',' -v now="$now" 'NR > 1 && tolower($5) == "menunggak" {
        printf "[%s] TAGIHAN: %s (Kamar %s) - Menunggak Rp%s\n", now, $1, $2, $3
    }' "$DATA_FILE" >> "$LOG_FILE"
}
```
