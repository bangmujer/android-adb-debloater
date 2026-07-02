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
