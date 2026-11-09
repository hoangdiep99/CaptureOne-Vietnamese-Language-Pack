@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
title Cài Đặt Gói Tiếng Việt Chuẩn Cho Capture One (Windows)

:: 1. Tự động nâng quyền Administrator nếu chưa có
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Đang yêu cầu quyền Quản trị viên (Administrator)...
    powershell -NoProfile -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

:: 2. Chuyển thư mục làm việc về đúng thư mục chứa file .bat
cd /d "%~dp0"

echo ================================================================
echo   🇻🇳 CÀI ĐẶT GÓI TIẾNG VIỆT CHUẨN NHIẾP ẢNH - CAPTURE ONE
echo ================================================================
echo.

:: 3. Kiểm tra nếu đang chạy trực tiếp từ WinRAR / 7-Zip trong thư mục Temp
echo "%CD%" | findstr /i "AppData\Local\Temp" >nul
if %errorlevel% equ 0 (
    echo [X] LỖI: BẠN ĐANG CHẠY TRỰC TIẾP TỪ TRONG FILE NÉN!
    echo.
    echo 👉 Vui lòng giải nén toàn bộ file ZIP ra một thư mục (ví dụ ngoài Desktop
    echo    hoặc Downloads), sau đó mới nhấp đúp vào file này để cài đặt.
    echo.
    pause
    exit /b 1
)

:: 4. Kiểm tra file ngôn ngữ đi kèm
set "SRC_LOC="
if exist "%~dp0P1.C1.Localization.dll" set "SRC_LOC=%~dp0P1.C1.Localization.dll"
if not defined SRC_LOC if exist "%~dp0vietnamese_pack\P1.C1.Localization.dll" set "SRC_LOC=%~dp0vietnamese_pack\P1.C1.Localization.dll"

set "SRC_VI="
if exist "%~dp0vi\CaptureOne.resources.dll" set "SRC_VI=%~dp0vi"
if not defined SRC_VI if exist "%~dp0vietnamese_pack\vi\CaptureOne.resources.dll" set "SRC_VI=%~dp0vietnamese_pack\vi"

if not defined SRC_LOC (
    echo [X] LỖI: Không tìm thấy file P1.C1.Localization.dll!
    echo Vui lòng đảm bảo bạn đã giải nén đầy đủ tất cả các file trong bộ cài.
    echo.
    pause
    exit /b 1
)

:: 5. Tắt toàn bộ các tiến trình Capture One đang chạy ngầm để tránh khóa file
echo [*] Đang kiểm tra và đóng các tiến trình Capture One...
taskkill /F /IM CaptureOne.exe >nul 2>&1
taskkill /F /IM CaptureOne.* >nul 2>&1
taskkill /F /IM P1.CrashReporter.exe >nul 2>&1
taskkill /F /IM ImgCoreProcess.exe >nul 2>&1
timeout /t 1 /nobreak >nul

:: 6. Tự động dò tìm thư mục cài đặt Capture One
echo [*] Đang dò tìm thư mục cài đặt Capture One trên máy tính...
set "C1_DIR="

:: Dò qua Registry HKLM
for /f "tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\Capture One\Capture One\16" /v ApplicationPath 2^>nul') do (
    if exist "%%b\CaptureOne.exe" set "C1_DIR=%%b"
    if exist "%%b\CaptureOne.dll" set "C1_DIR=%%b"
)
if not defined C1_DIR (
    for /f "tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\Capture One\Capture One" /s /v ApplicationPath 2^>nul') do (
        if exist "%%b\CaptureOne.exe" set "C1_DIR=%%b"
    )
)

:: Dò qua các đường dẫn phổ biến
if not defined C1_DIR if exist "C:\Program Files\Capture One\Capture One\CaptureOne.dll" set "C1_DIR=C:\Program Files\Capture One\Capture One"
if not defined C1_DIR if exist "C:\Program Files\Capture One\CaptureOne.dll" set "C1_DIR=C:\Program Files\Capture One"
if not defined C1_DIR if exist "C:\Program Files\Capture One\Capture One 23\CaptureOne.dll" set "C1_DIR=C:\Program Files\Capture One\Capture One 23"
if not defined C1_DIR if exist "C:\Program Files\Capture One\Capture One 22\CaptureOne.dll" set "C1_DIR=C:\Program Files\Capture One\Capture One 22"
if not defined C1_DIR if exist "C:\Program Files (x86)\Capture One\Capture One\CaptureOne.dll" set "C1_DIR=C:\Program Files (x86)\Capture One\Capture One"
if not defined C1_DIR if exist "D:\Program Files\Capture One\Capture One\CaptureOne.dll" set "C1_DIR=D:\Program Files\Capture One\Capture One"
if not defined C1_DIR if exist "D:\Capture One\CaptureOne.dll" set "C1_DIR=D:\Capture One"

:: Nếu vẫn chưa tìm thấy, cho phép nhập tay
if not defined C1_DIR (
    echo.
    echo [!] Không tự động tìm thấy thư mục cài đặt Capture One.
    echo 👉 Bạn hãy mở thư mục chứa CaptureOne.exe trên máy của bạn,
    set /p "C1_DIR=sao chép đường dẫn rồi dán vào đây (ví dụ C:\Program Files\Capture One): "
    set "C1_DIR=!C1_DIR:"=!"
)

if not exist "!C1_DIR!\CaptureOne.dll" if not exist "!C1_DIR!\CaptureOne.exe" (
    echo.
    echo [X] LỖI: Thư mục bạn nhập không phải là thư mục cài đặt Capture One!
    pause
    exit /b 1
)

echo [+] Đã định vị thư mục ứng dụng: "!C1_DIR!"

:: 7. Sao lưu file gốc nếu chưa từng sao lưu
if exist "!C1_DIR!\P1.C1.Localization.dll" (
    if not exist "!C1_DIR!\P1.C1.Localization.dll.orig" (
        echo [*] Đang sao lưu file gốc: P1.C1.Localization.dll.orig...
        copy /y "!C1_DIR!\P1.C1.Localization.dll" "!C1_DIR!\P1.C1.Localization.dll.orig" >nul
    )
)

:: 8. Sao chép file ngôn ngữ và kiểm tra kết quả
echo [*] Đang sao chép file ngôn ngữ P1.C1.Localization.dll...
attrib -r "!C1_DIR!\P1.C1.Localization.dll" >nul 2>&1
copy /y "!SRC_LOC!" "!C1_DIR!\P1.C1.Localization.dll" >nul
if %errorlevel% neq 0 (
    echo.
    echo [X] LỖI: Không thể ghi đè file P1.C1.Localization.dll!
    echo Có thể Capture One đang chạy ngầm hoặc phần mềm diệt virus đang khóa file.
    pause
    exit /b 1
)

echo [*] Đang cài đặt các file tài nguyên dịch tiếng Việt (vi/*.resources.dll)...
if not exist "!C1_DIR!\vi" mkdir "!C1_DIR!\vi"
copy /y "!SRC_VI!\*.resources.dll" "!C1_DIR!\vi\" >nul

:: 9. Mở khóa file (Unblock Mark of the Web do Windows chặn)
echo [*] Đang mở khóa bảo mật tệp tin (Unblock-File)...
powershell -NoProfile -Command "Unblock-File -Path '!C1_DIR!\P1.C1.Localization.dll' -ErrorAction SilentlyContinue; Unblock-File -Path '!C1_DIR!\vi\*' -ErrorAction SilentlyContinue" >nul 2>&1

:: 10. Tự động thiết lập UICulture = vi trong user.config
echo [*] Đang thiết lập ngôn ngữ hiển thị mặc định là Tiếng Việt...
powershell -NoProfile -Command "$local = [System.Environment]::GetFolderPath('LocalApplicationData'); $dirs = Get-ChildItem -Path (Join-Path $local 'Capture_One') -Filter 'CaptureOne_StrongName_*' -ErrorAction SilentlyContinue; foreach ($d in $dirs) { $files = Get-ChildItem -Path $d.FullName -Recurse -Filter 'user.config' -ErrorAction SilentlyContinue; foreach ($f in $files) { try { $c = [System.IO.File]::ReadAllText($f.FullName); if ($c -match '<setting name=\"UICulture\" serializeAs=\"String\">\s*<value>.*?<\/value>') { $c = [System.Text.RegularExpressions.Regex]::Replace($c, '(<setting name=\"UICulture\" serializeAs=\"String\">\s*<value>)(.*?)(<\/value>)', '${1}vi${3}'); [System.IO.File]::WriteAllText($f.FullName, $c); } else { $tag = '<P1.C1.ApplicationSettings>'; if ($c.Contains($tag)) { $sub = \"$tag`r`n            <setting name=`\"UICulture`\" serializeAs=`\"String`\">`r`n                <value>vi</value>`r`n            </setting>\"; $c = $c.Replace($tag, $sub); [System.IO.File]::WriteAllText($f.FullName, $c); } } } catch {} } }" >nul 2>&1

echo.
echo ================================================================
echo   🎉 CÀI ĐẶT GÓI TIẾNG VIỆT CHUẨN THÀNH CÔNG!
echo ================================================================
echo.
echo [+] Đã kích hoạt ngôn ngữ Tiếng Việt cho Capture One.
echo [+] Để quay về Tiếng Anh gốc bất cứ khi nào, chạy file: Khoi_Phuc_Tieng_Anh.bat
echo.
set /p OPEN_NOW="Bạn có muốn mở Capture One ngay bây giờ không? (Y/N): "
if /i "!OPEN_NOW!"=="Y" (
    if exist "!C1_DIR!\CaptureOne.exe" (
        start "" "!C1_DIR!\CaptureOne.exe"
    )
)
