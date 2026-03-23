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

### Soal 1: KERETA ARGO NGAWI JESGEJES

Pada soal nomor 1, diminta untuk membuat script bebasis AWK yang digunakan untuk membaca file [passenger.csv](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_1/passenger.csv) dan menghasilkan beberapa informasi mengenai penumpang berdasarkan opsi yang dipilih.

Seluruh interaksi pada soal 1 dapat dilakukan dengan mengeksekusi file [KANJ.sh](https://github.com/catursetyo/SISOP-1-2026-IT-066/blob/main/soal_1/KANJ.sh) beserta opsi (a, b, c, d, atau e) yang dipilihnya.

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
