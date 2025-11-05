#!/bin/bash
# ====================================================
# CEK TUGAS PRAKTIK - LINUX DASAR
# Author: David Wahyu Pratama
# Pelajaran: Sistem Komputer
# Versi: 1.0
# ====================================================

# Inisialisasi variabel
TOTAL_NILAI=0
MAX_NILAI=100
POINTS_PER_SECTION=10

# Fungsi untuk menampilkan hasil cek
check() {
  local kondisi=$1
  local deskripsi=$2
  if [ "$kondisi" = true ]; then
    echo "✅ $deskripsi"
    ((TOTAL_NILAI+=POINTS_PER_SECTION))
  else
    echo "❌ $deskripsi"
  fi
}

echo "==========================================="
echo "🔍 CEK TUGAS PRAKTIK SISKOM LINUX DASAR"
echo "==========================================="

# 1. Cek folder latihan_cli
check -d ~/latihan_cli "Folder latihan_cli ada"

# 2. Cek subfolder dokumen, gambar, projek
check -d ~/latihan_cli/dokumen "Folder dokumen ada"
check -d ~/latihan_cli/projek "Folder projek ada"

# 3. Cek file catatan.txt di dalam gambar atau projek
if [ -f ~/latihan_cli/gambar/catatan.txt ] || [ -f ~/latihan_cli/projek/catatan.txt ]; then
  check true "File catatan.txt ditemukan"
else
  check false "File catatan.txt tidak ditemukan"
fi

# 4. Cek isi file catatan.txt
if grep -q "Belajar Linux itu menyenangkan" ~/latihan_cli/*/catatan.txt 2>/dev/null; then
  check true "Isi catatan.txt sesuai"
else
  check false "Isi catatan.txt tidak sesuai"
fi

# 5. Cek file info.txt berisi nama & tanggal
if [ -f ~/latihan_cli/info.txt ]; then
  if grep -q "Tugas Linux Dasar" ~/latihan_cli/info.txt && grep -q "Tanggal praktik" ~/latihan_cli/info.txt; then
    check true "File info.txt berisi nama & tanggal"
  else
    check false "Isi info.txt belum lengkap"
  fi
else
  check false "File info.txt tidak ditemukan"
fi

# 6. Cek apakah user siswa01 ada
if id "siswa01" &>/dev/null; then
  check true "User siswa01 sudah dibuat"
else
  check false "User siswa01 belum dibuat"
fi

# 7. Cek timezone Asia/Jakarta
if timedatectl | grep -q "Asia/Jakarta"; then
  check true "Zona waktu sudah Asia/Jakarta"
else
  check false "Zona waktu belum Asia/Jakarta"
fi

# 8. Cek apakah neofetch terinstal
if command -v neofetch &>/dev/null; then
  check true "Neofetch sudah terinstal"
else
  check false "Neofetch belum terinstal"
fi

# 9. Cek apakah ada file neofetch.txt
if [ -f ~/latihan_cli/neofetch.txt ]; then
  check true "Output neofetch.txt ditemukan"
else
  check false "Output neofetch.txt belum dibuat"
fi

# 10. Cek file penjelasan.txt minimal berisi 10 baris
if [ -f ~/latihan_cli/penjelasan.txt ]; then
  LINES=$(wc -l < ~/latihan_cli/penjelasan.txt)
  if [ "$LINES" -ge 10 ]; then
    check true "File penjelasan.txt lengkap"
  else
    check false "File penjelasan.txt belum lengkap"
  fi
else
  check false "File penjelasan.txt tidak ditemukan"
fi

echo "==========================================="
echo "🎯 TOTAL NILAI: $TOTAL_NILAI / $MAX_NILAI"
echo "==========================================="

# Tambahkan penilaian kategori
if [ $TOTAL_NILAI -ge 90 ]; then
  GRADE="A (Sangat Baik)"
elif [ $TOTAL_NILAI -ge 75 ]; then
  GRADE="B (Baik)"
elif [ $TOTAL_NILAI -ge 60 ]; then
  GRADE="C (Cukup)"
else
  GRADE="D (Perlu Bimbingan)"
fi

echo "🧾 Nilai Akhir: $GRADE"
echo "==========================================="
