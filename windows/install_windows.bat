@echo off
chcp 65001 >nul
title Cài Đặt Gói Tiếng Việt Chuẩn Cho Capture One (Windows)

:: Kiểm tra quyền Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Đang yêu cầu quyền Administrator...
    powershell -NoProfile -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

echo ================================================================
echo   🇻🇳 CÀI ĐẶT GÓI TIẾNG VIỆT CHUẨN NHIẾP ẢNH - CAPTURE ONE
echo ================================================================
echo.

:: 1. Tắt Capture One nếu đang chạy
echo [*] Đang kiểm tra và đóng tiến trình Capture One...
taskkill /F /IM CaptureOne.exe >nul 2>&1
timeout /t 1 /nobreak >nul

:: 2. Định vị thư mục cài đặt Capture One
set "C1_DIR="
if exist "C:\Program Files\Capture One\Capture One\CaptureOne.dll" set "C1_DIR=C:\Program Files\Capture One\Capture One"
if not defined C1_DIR if exist "C:\Program Files\Capture One\CaptureOne.dll" set "C1_DIR=C:\Program Files\Capture One"
if not defined C1_DIR if exist "C:\Program Files (x86)\Capture One\Capture One\CaptureOne.dll" set "C1_DIR=C:\Program Files (x86)\Capture One\Capture One"

if not defined C1_DIR (
    echo [X] LỖI: Không tìm thấy thư mục cài đặt Capture One trên máy!
    echo Vui lòng đảm bảo bạn đã cài đặt Capture One 16.x trước khi chạy script.
    pause
    exit /b 1
)

echo [+] Đã tìm thấy Capture One tại: "%C1_DIR%"
set "SCRIPT_DIR=%~dp0"
set "PACK_DIR=%SCRIPT_DIR%vietnamese_pack"

if not exist "%PACK_DIR%\P1.C1.Localization.dll" (
    echo [X] LỖI: Thiếu thư mục vietnamese_pack!
    pause
    exit /b 1
)

:: 3. Sao lưu file gốc nếu chưa có
if exist "%C1_DIR%\P1.C1.Localization.dll" (
    if not exist "%C1_DIR%\P1.C1.Localization.dll.orig" (
        echo [*] Đang tạo bản sao lưu an toàn: P1.C1.Localization.dll.orig...
        copy /y "%C1_DIR%\P1.C1.Localization.dll" "%C1_DIR%\P1.C1.Localization.dll.orig" >nul
    )
)

:: 4. Sao chép file ngôn ngữ
echo [*] Đang cài đặt P1.C1.Localization.dll (kích hoạt menu Tiếng Việt)...
copy /y "%PACK_DIR%\P1.C1.Localization.dll" "%C1_DIR%\P1.C1.Localization.dll" >nul

echo [*] Đang cài đặt các tài nguyên tiếng Việt (vi/*.resources.dll)...
if not exist "%C1_DIR%\vi" mkdir "%C1_DIR%\vi"
copy /y "%PACK_DIR%\vi\*.resources.dll" "%C1_DIR%\vi\" >nul

:: 5. Mở khóa file (Unblock)
powershell -NoProfile -Command "Unblock-File -Path '%C1_DIR%\*' -ErrorAction SilentlyContinue; Unblock-File -Path '%C1_DIR%\vi\*' -ErrorAction SilentlyContinue" >nul 2>&1

:: 6. Thiết lập UICulture = vi trong user.config
powershell -NoProfile -Command "$dirs = Get-ChildItem -Path \"$env:LOCALAPPDATA\Capture_One\CaptureOne_StrongName_*\" -ErrorAction SilentlyContinue; foreach ($d in $dirs) { $files = Get-ChildItem -Path $d.FullName -Recurse -Filter 'user.config' -ErrorAction SilentlyContinue; foreach ($f in $files) { $c = [System.IO.File]::ReadAllText($f.FullName); if ($c -match '<setting name=\"UICulture\" serializeAs=\"String\">\s*<value>.*?<\/value>') { $c = [System.Text.RegularExpressions.Regex]::Replace($c, '(<setting name=\"UICulture\" serializeAs=\"String\">\s*<value>)(.*?)(<\/value>)', '${1}vi${3}'); [System.IO.File]::WriteAllText($f.FullName, $c); } } }" >nul 2>&1

echo.
echo ================================================================
echo   🎉 CÀI ĐẶT GÓI TIẾNG VIỆT CHUẨN THÀNH CÔNG!
echo ================================================================
echo.
echo Giao diện Tiếng Việt đã được kích hoạt.
echo Để quay về Tiếng Anh gốc bất cứ khi nào, chạy file: restore_windows.bat
echo.
set /p OPEN_NOW="Bạn có muốn khởi động Capture One ngay bây giờ không? (Y/N): "
if /i "%OPEN_NOW%"=="Y" (
    if exist "%C1_DIR%\CaptureOne.exe" (
        start "" "%C1_DIR%\CaptureOne.exe"
    )
)
