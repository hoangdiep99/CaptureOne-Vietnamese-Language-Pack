#!/bin/bash
set -e

echo "=========================================================="
echo " 🔄 KHÔI PHỤC TIẾNG ANH GỐC CHO CAPTURE ONE TRÊN MAC "
echo "=========================================================="

if [ "$EUID" -ne 0 ]; then
  echo "👉 Vui lòng chạy lệnh với quyền quản trị: sudo ./restore_mac.sh"
  exit 1
fi

APP_PATH="/Applications/Capture One.app"
if [ ! -d "$APP_PATH" ]; then
  APP_PATH=$(find /Applications -maxdepth 1 -name "Capture One*.app" | head -n 1)
fi

if [ -d "$APP_PATH/Contents/Resources/vi.lproj" ]; then
  rm -rf "$APP_PATH/Contents/Resources/vi.lproj"
  echo "✅ Đã gỡ bỏ thư mục vi.lproj."
fi

BUNDLE_ID=$(defaults read "$APP_PATH/Contents/Info.plist" CFBundleIdentifier 2>/dev/null || echo "com.captureone.captureone16")
CURRENT_USER=$(stat -f "%Su" /dev/console)
if [ -n "$CURRENT_USER" ] && [ "$CURRENT_USER" != "root" ]; then
  su - "$CURRENT_USER" -c "defaults delete $BUNDLE_ID AppleLanguages 2>/dev/null || true"
fi

echo "✅ Đã khôi phục cài đặt ngôn ngữ mặc định."
echo "🎉 Đã đưa Capture One về tiếng Anh gốc thành công!"
