@echo off
setlocal EnableDelayedExpansion
:: Menyesuaikan ukuran window terminal agar rapi
mode con: cols=85 lines=35
title Android ADB Debloater - by Bang Mujer
color 0B

:: =========================================================================
:: CHECKING & AUTO-DOWNLOAD ADB DRIVER (PLATFORM TOOLS)
:: =========================================================================
echo Mengecek dependensi ADB...
where adb >nul 2>&1
if %errorlevel% neq 0 (
    if exist "%~dp0platform-tools\adb.exe" (
        set "PATH=%PATH%;%~dp0platform-tools"
    ) else (
        echo.
        echo [!] ADB / Fastboot driver belum ditemukan!
        echo Mendownload Android Platform Tools resmi dari Google...
        curl -L -o platform-tools.zip https://dl.google.com/android/repository/platform-tools-latest-windows.zip
        if not exist platform-tools.zip (
            echo Gagal mendownload. Cek koneksi internet.
            pause
            exit /b
        )
        echo.
        echo Mengekstrak file...
        powershell -command "Expand-Archive -Force -Path platform-tools.zip -DestinationPath '%~dp0'"
        del platform-tools.zip
        set "PATH=%PATH%;%~dp0platform-tools"
        echo Instalasi ADB berhasil!
        timeout /t 2 >nul
    )
)

:: =========================================================================
:: DAFTAR BLOATWARE AMAN (Tambahkan package di sini, pisahkan dengan spasi)
:: =========================================================================
set "bloatware_list=com.google.android.apps.tachyon com.google.android.videos com.google.android.music com.google.android.apps.books com.facebook.services com.facebook.appmanager com.facebook.system com.google.ar.lens"

:menu
cls
color 0B
echo.
echo    █████╗ ██████╗ ██████╗ 
echo   ██╔══██╗██╔══██╗██╔══██╗
echo   ███████║██║  ██║██████╔╝
echo   ██╔══██║██║  ██║██╔══██╗
echo   ██║  ██║██████╔╝██████╔╝
echo   ╚═╝  ╚═╝╚═════╝ ╚═════╝ 
echo   ===========================================================
echo         ANDROID ADB DEBLOATER TOOL v4.0 - by Bang Mujer
echo   ===========================================================
echo   [1]. Cek Device Terhubung
echo   [2]. Lihat Daftar Aplikasi di HP (User ^& System)
echo   [3]. Scan ^& Hapus Bloatware Bawaan (Auto)
echo   [4]. Hapus Aplikasi Manual (Multi Input)
echo   [5]. Restore Aplikasi (Multi Input)
echo   [6]. Bersihkan Semua Cache HP (Aman)
echo   [7]. Hapus Data App / pm clear (RESIKO TINGGI)
echo   [8]. Export Daftar Aplikasi ke File TXT
echo   [9]. Reboot Device
echo   [10]. Keluar
echo   ===========================================================
set /p pilihan="Pilih menu (1-10): "

if "%pilihan%"=="1" goto cek_device
if "%pilihan%"=="2" goto lihat_aplikasi
if "%pilihan%"=="3" goto debloat_auto
if "%pilihan%"=="4" goto debloat_manual
if "%pilihan%"=="5" goto restore_manual
if "%pilihan%"=="6" goto clear_cache
if "%pilihan%"=="7" goto clear_data
if "%pilihan%"=="8" goto export_txt
if "%pilihan%"=="9" goto reboot_dev
if "%pilihan%"=="10" goto eof

:cek_device
cls
echo -------------------------------------------------------
echo  Mengecek device yang terhubung...
echo -------------------------------------------------------
adb devices
echo.
pause
goto menu

:lihat_aplikasi
cls
echo =======================================================
echo         TAMPILKAN DAFTAR APLIKASI (LIVE)
echo =======================================================
echo [1]. Aplikasi User (Third-Party / Diinstal Sendiri)
echo [2]. Semua Aplikasi System (Total Bawaan Pabrik)
echo [3]. Aplikasi System yang AMAN Dihapus (Sesuai Filter)
echo [4]. Kembali ke Menu Utama
echo =======================================================
set /p app_menu="Pilih (1-4): "

if "%app_menu%"=="1" (
    cls
    echo =======================================================
    echo DAFTAR APLIKASI USER (BISA DIHAPUS BEBAS):
    echo =======================================================
    adb shell pm list packages -3
    echo.
    pause
    goto lihat_aplikasi
)
if "%app_menu%"=="2" (
    cls
    echo =======================================================
    echo DAFTAR SEMUA APLIKASI SYSTEM (HATI-HATI!):
    echo =======================================================
    adb shell pm list packages -s
    echo.
    pause
    goto lihat_aplikasi
)
if "%app_menu%"=="3" (
    cls
    echo =======================================================
    echo MENGANALISA APLIKASI SYSTEM YANG AMAN DIHAPUS...
    echo =======================================================
    adb shell pm list packages -s > temp_sys.txt
    set "ketemu=0"
    for %%p in (%bloatware_list%) do (
        findstr /i "package:%%p" temp_sys.txt >nul
        if not errorlevel 1 (
            echo [AMAN DIHAPUS] - %%p
            set "ketemu=1"
        )
    )
    del temp_sys.txt
    if "!ketemu!"=="0" echo Tidak ada aplikasi dari daftar aman yang terdeteksi.
    echo -------------------------------------------------------
    echo * Daftar ini difilter berdasarkan variabel "bloatware_list".
    echo.
    pause
    goto lihat_aplikasi
)
if "%app_menu%"=="4" goto menu
goto lihat_aplikasi

:debloat_auto
cls
echo Mengambil daftar aplikasi yang ter-install di device...
adb shell pm list packages > temp_pkg.txt
echo.
echo =======================================================
echo BLOATWARE YANG TERDETEKSI DI DEVICE INI:
echo =======================================================
set "ada_bloatware=0"
for %%p in (%bloatware_list%) do (
    findstr /i "package:%%p" temp_pkg.txt >nul
    if not errorlevel 1 (
        echo [ADA] - %%p
        set "ada_bloatware=1"
    )
)
del temp_pkg.txt
echo.
if "!ada_bloatware!"=="0" (
    echo Tidak ada bloatware dari daftar yang ditemukan.
    pause
    goto menu
)
set /p konfirmasi="Hapus semua aplikasi di atas sekaligus? (Y/N): "
if /i "%konfirmasi%"=="Y" (
    echo.
    for %%p in (%bloatware_list%) do (
        adb shell pm list packages | findstr "package:%%p" >nul
        if not errorlevel 1 (
            echo Menghapus %%p...
            adb shell pm uninstall --user 0 %%p
        )
    )
    echo PROSES SELESAI!
) else (
    echo Dibatalkan.
)
pause
goto menu

:debloat_manual
cls
echo =======================================================
echo HAPUS MANUAL (BISA BANYAK SEKALIGUS)
echo Pisahkan dengan SPASI. Contoh: com.a.app com.b.app
echo =======================================================
set /p pkgs="Masukkan nama package: "
echo.
for %%p in (%pkgs%) do (
    echo Menghapus: %%p
    adb shell pm uninstall --user 0 %%p
)
echo Selesai.
pause
goto menu

:restore_manual
cls
echo =======================================================
echo RESTORE MANUAL (BISA BANYAK SEKALIGUS)
echo Pisahkan dengan SPASI. Contoh: com.a.app com.b.app
echo =======================================================
set /p pkgs="Masukkan nama package yang mau direstore: "
echo.
for %%p in (%pkgs%) do (
    echo Merestore: %%p
    adb shell cmd package install-existing %%p
)
echo Selesai.
pause
goto menu

:clear_cache
cls
echo =======================================================
echo MEMBERSIHKAN CACHE SEMUA APLIKASI DI HP...
echo (Aman, tidak akan menghapus data login/akun)
echo =======================================================
adb shell pm trim-caches 999999999999999999
echo Proses selesai!
pause
goto menu

:clear_data
cls
color 4F
echo ============================================================
echo     [ PERINGATAN BAHAYA - RESIKO DITANGGUNG SENDIRI ]
echo ============================================================
echo  Fitur ini mengeksekusi "pm clear" yang akan mengakibatkan:
echo  - SEMUA DATA, LOGIN, SETTING, ^& HISTORY APLIKASI DIHAPUS.
echo  - Aplikasi akan tersetel ulang seperti baru diinstal.
echo ============================================================
set /p konfirmasi="Ketik 'YAKIN' untuk melanjutkan, atau Enter untuk batal: "
if /i not "%konfirmasi%"=="YAKIN" (
    color 0B
    echo Dibatalkan.
    pause
    goto menu
)
echo.
echo Masukkan nama package (Pisahkan dengan SPASI untuk multi-input)
set /p pkgs="Package: "
echo.
for %%p in (%pkgs%) do (
    echo Menghapus Data: %%p
    adb shell pm clear %%p
)
color 0B
echo Selesai mengeksekusi penghapusan data.
pause
goto menu

:export_txt
cls
echo Mengekstrak daftar package dari HP...
adb shell pm list packages -3 > daftar_aplikasi_user.txt
adb shell pm list packages -s > daftar_aplikasi_system.txt
echo.
echo Berhasil! File "daftar_aplikasi_user.txt" ^& "daftar_aplikasi_system.txt" 
echo telah dibuat di folder ini.
pause
goto menu

:reboot_dev
cls
echo =======================================================
echo 1. Reboot Normal
echo 2. Reboot ke Recovery
echo 3. Reboot ke Bootloader (Fastboot)
echo 4. Batal
echo =======================================================
set /p rb="Pilih opsi reboot: "
if "%rb%"=="1" adb reboot
if "%rb%"=="2" adb reboot recovery
if "%rb%"=="3" adb reboot bootloader
echo Mengeksekusi perintah...
pause
goto menu
