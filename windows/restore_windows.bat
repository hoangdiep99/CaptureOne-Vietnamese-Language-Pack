@echo off
chcp 65001 >nul
title Khôi Phục Tiếng Anh Gốc Cho Capture One (Windows)

:: Kiểm tra quyền Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Đang yêu cầu quyền Administrator...
    powershell -NoProfile -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

echo ================================================================
echo   🔄 KHÔI PHỤC TIẾNG ANH GỐC - CAPTURE ONE (WINDOWS)
echo ================================================================
echo.

:: 1. Tắt Capture One
echo [*] Đang kiểm tra và đóng tiến trình Capture One...
taskkill /F /IM CaptureOne.exe >nul 2>&1
timeout /t 1 /nobreak >nul

:: 2. Định vị thư mục cài đặt
set "C1_DIR="
if exist "C:\Program Files\Capture One\Capture One\CaptureOne.dll" set "C1_DIR=C:\Program Files\Capture One\Capture One"
if not defined C1_DIR if exist "C:\Program Files\Capture One\CaptureOne.dll" set "C1_DIR=C:\Program Files\Capture One"
if not defined C1_DIR if exist "C:\Program Files (x86)\Capture One\Capture One\CaptureOne.dll" set "C1_DIR=C:\Program Files (x86)\Capture One\Capture One"

if not defined C1_DIR (
    echo [X] LỖI: Không tìm thấy thư mục Capture One!
    pause
    exit /b 1
)

:: 3. Phục hồi file gốc
if exist "%C1_DIR%\P1.C1.Localization.dll.orig" (
    echo [*] Đang khôi phục P1.C1.Localization.dll gốc...
    copy /y "%C1_DIR%\P1.C1.Localization.dll.orig" "%C1_DIR%\P1.C1.Localization.dll" >nul
)

:: 4. Xóa thư mục vi
if exist "%C1_DIR%\vi" (
    echo [*] Đang gỡ bỏ gói vi/...
    rd /s /q "%C1_DIR%\vi" >nul 2>&1
)

:: 5. Khôi phục UICulture = en
powershell -NoProfile -Command "$dirs = Get-ChildItem -Path \"$env:LOCALAPPDATA\Capture_One\CaptureOne_StrongName_*\" -ErrorAction SilentlyContinue; foreach ($d in $dirs) { $files = Get-ChildItem -Path $d.FullName -Recurse -Filter 'user.config' -ErrorAction SilentlyContinue; foreach ($f in $files) { $c = [System.IO.File]::ReadAllText($f.FullName); if ($c -match '<setting name=\"UICulture\" serializeAs=\"String\">\s*<value>.*?<\/value>') { $c = [System.Text.RegularExpressions.Regex]::Replace($c, '(<setting name=\"UICulture\" serializeAs=\"String\">\s*<value>)(.*?)(<\/value>)', '${1}en${3}'); [System.IO.File]::WriteAllText($f.FullName, $c); } } }" >nul 2>&1

echo.
echo ================================================================
echo   🎉 ĐÃ KHÔI PHỤC TIẾNG ANH GỐC THÀNH CÔNG!
echo ================================================================
echo.
pause
