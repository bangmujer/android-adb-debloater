# 🚀 Android ADB Debloater Tool 

Sebuah *script batch* interaktif untuk OS Windows yang dirancang agar mempermudah proses penghapusan aplikasi bawaan (*bloatware*), pembersihan *cache*, dan manajemen aplikasi di HP Android **tanpa memerlukan akses U-Boot/Root**. 

Dikembangkan agar *plug-and-play*: **Otomatis mendeteksi dan mendownload driver ADB & Fastboot (Android Platform Tools)** jika belum terinstal di PC Anda!

👤 **Author:** Bang Mujer

---

## ⚠️ Prasyarat Wajib (Sebelum Mulai)
Agar tool ini bisa berjalan dan mendeteksi HP Anda, pastikan:
1. Anda menggunakan PC/Laptop dengan OS **Windows**.
2. HP terhubung ke PC menggunakan kabel data (kabel USB).
3. **USB Debugging** di HP sudah **AKTIF**. 
   *(Cara aktifkan: Pergi ke Pengaturan > Tentang Ponsel > Ketuk "Build Number" 7x > Buka Opsi Pengembang / Developer Options > Aktifkan USB Debugging).*
4. Saat dicolokkan ke PC, jika muncul notifikasi **"Allow USB Debugging?"** di layar HP, pastikan Anda mencentang *Always allow* dan klik **OK**.

---

## 📥 Cara Download & Eksekusi

Ada dua cara untuk menggunakan tool ini, pilih yang menurut Anda paling mudah:

### METODE 1: Auto-Run via Terminal CMD (Paling Cepat)
Anda tidak perlu repot mendownload file secara manual. Cukup buka Terminal dan jalankan satu baris perintah ini:

1. Tekan tombol `Windows + R` di keyboard, ketik `cmd`, lalu tekan **Enter**.
2. *Copy* dan *Paste* perintah di bawah ini ke dalam CMD, lalu tekan **Enter**:
   ```cmd
   curl -sL "[https://raw.githubusercontent.com/bangmujer/android-adb-debloater/main/debloater.bat](https://raw.githubusercontent.com/bangmujer/android-adb-debloater/main/debloater.bat)" > debloater.bat && debloater.bat
3. Tool akan otomatis didownload dan langsung terbuka di layar Anda.

### METODE 2: Download Manual
1. Di halaman GitHub ini, klik file ⁠debloater.bat⁠.
2. Klik tombol Download raw file (ikon panah ke bawah) di pojok kanan atas area kode.
3. Simpan file di folder mana saja di PC Anda (misal: di Desktop).
4. Klik 2x (Double-Click) file ⁠debloater.bat⁠ tersebut untuk membukanya.

### 🛠️ Panduan Penggunaan & Fitur Menu
Saat program terbuka, Anda akan melihat beberapa opsi menu:
1. Cek Device Terhubung: Gunakan ini pertama kali untuk memastikan HP sudah terdeteksi. Harus ada tulisan ⁠device⁠ di samping nomor seri HP. Kalau tulisannya ⁠unauthorized⁠, cek layar HP dan izinkan USB Debugging.
2. Lihat Daftar Aplikasi di HP: Fitur untuk melihat semua package aplikasi. Anda bisa memfilter khusus aplikasi user (yang diinstal sendiri), aplikasi sistem bawaan, atau aplikasi sistem yang Aman Dihapus.
3. Scan & Hapus Bloatware Bawaan (Auto): Tool akan otomatis memindai HP Anda dan membandingkannya dengan daftar bloatware umum (seperti Google Play Movies, Facebook App Manager, AR Lens, dll). Anda bisa menghapus semuanya sekaligus hanya dengan mengetik ⁠Y⁠.
4. Hapus Aplikasi Manual (Multi Input): Hapus aplikasi spesifik. Anda bisa memasukkan banyak package sekaligus dengan memisahkannya menggunakan spasi. (Contoh: ⁠com.google.ar.lens com.facebook.katana⁠).
5. Restore Aplikasi: Jika ada aplikasi sistem yang tidak sengaja terhapus dan sistem menjadi error, masukkan nama package-nya di sini untuk mengembalikannya secara utuh tanpa perlu factory reset.
6. Bersihkan Semua Cache HP: Membersihkan file sampah (cache) dari semua aplikasi secara otomatis dan sangat aman. Tidak akan menghapus akun, login, atau data penting!
7. Hapus Data App / pm clear (RESIKO TINGGI): Mereset aplikasi tertentu ke kondisi awal seperti baru diunduh. Perhatian: Semua data login dan pengaturan di dalam aplikasi tersebut akan hilang!
8. Export Daftar Aplikasi ke File TXT: Menyimpan daftar semua nama aplikasi di HP Anda ke dalam file ⁠.txt⁠ di PC agar mudah disalin/dibaca.
9. Reboot Device: Opsi shortcut untuk merestart HP ke mode Normal, Recovery, atau Bootloader (Fastboot).

### 💡 Kustomisasi (Advance User)
Anda tidak perlu lagi mengedit file ⁠.bat⁠ untuk menambah target aplikasi bloatware. Saat pertama kali dijalankan, script ini akan otomatis membuat file bernama ⁠bloatware_list.txt⁠ di folder yang sama. Anda cukup membuka file ⁠.txt⁠ tersebut, lalu tambahkan nama package aplikasi pengganggu yang ingin dihapus (bisa ditekan Enter ke bawah atau dipisah spasi).

## Penafian (Disclaimer)
Tool ini hanya melakukan uninstalasi di level "User" (⁠--user 0⁠), yang berarti aplikasi sebenarnya tidak terhapus dari partisi sistem Android, melainkan disembunyikan dan di-nonaktifkan secara total. Ini adalah metode yang paling aman. Jika terjadi error atau bootloop karena menghapus sistem inti, HP dapat dikembalikan ke keadaan normal dengan melakukan Factory Reset via Recovery Mode.
