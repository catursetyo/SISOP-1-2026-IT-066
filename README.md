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
> **Catatan:** Struktur di atas mengikuti format yang diminta pada soal. Namun untuk directory [/assets](https://github.com/catursetyo/SISOP-1-2026-IT-066/tree/main/assets) tidak termasuk ke dalam struktur repository, karena digunakan untuk keperluan laporan pada [README.md](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/README.md).

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

Pada langkah pertama, diminta untuk mendownload file [peta-ekspedisi-amba.pdf](https://drive.google.com/uc?id=1q10pHSC3KFfvEiCN3V6PTroPR7YGHF6Q) menggunakan `gdown`. Untuk menginstall `gdown` dapat dilakukan dengan menginisiasi python venv.
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

Script [nemupusaka.sh](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_2/ekspedisi/peta-gunung-kawi/nemupusaka.sh)