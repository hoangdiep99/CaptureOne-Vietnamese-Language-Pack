#!/bin/bash
set -e

echo "=========================================================="
echo " 🇻🇳 CÀI ĐẶT GÓI TIẾNG VIỆT CHUẨN CHO CAPTURE ONE TRÊN MAC "
echo "=========================================================="

if [ "$EUID" -ne 0 ]; then
  echo "👉 Vui lòng chạy lệnh với quyền quản trị: sudo ./install_mac.sh"
  exit 1
fi

APP_PATH="/Applications/Capture One.app"
if [ ! -d "$APP_PATH" ]; then
  APP_PATH=$(find /Applications -maxdepth 1 -name "Capture One*.app" | head -n 1)
fi

if [ -z "$APP_PATH" ] || [ ! -d "$APP_PATH" ]; then
  echo "❌ Không tìm thấy Capture One trong thư mục /Applications!"
  exit 1
fi

echo "✅ Tìm thấy ứng dụng: $APP_PATH"

echo "Đang đóng Capture One nếu đang chạy..."
killall "Capture One" 2>/dev/null || true
sleep 1

RESOURCES_DIR="$APP_PATH/Contents/Resources"
VI_LPROJ="$RESOURCES_DIR/vi.lproj"

echo "Đang cài đặt thư mục vi.lproj..."
mkdir -p "$VI_LPROJ"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cp -f "$SCRIPT_DIR/vi.lproj/Localizable.strings" "$VI_LPROJ/"
chmod -R 755 "$VI_LPROJ"

echo "Đang xóa cảnh báo bảo mật Gatekeeper & Ký lại ứng dụng..."
xattr -cr "$APP_PATH"
codesign --force --deep --sign - "$APP_PATH"

echo "Đang thiết lập ngôn ngữ mặc định là Tiếng Việt..."
BUNDLE_ID=$(defaults read "$APP_PATH/Contents/Info.plist" CFBundleIdentifier 2>/dev/null || echo "com.captureone.captureone16")
CURRENT_USER=$(stat -f "%Su" /dev/console)
if [ -n "$CURRENT_USER" ] && [ "$CURRENT_USER" != "root" ]; then
  su - "$CURRENT_USER" -c "defaults write $BUNDLE_ID AppleLanguages '(\"vi\")'"
fi

echo ""
echo "🎉 HOÀN TẤT CÀI ĐẶT TIẾNG VIỆT CHO CAPTURE ONE TRÊN MAC!"
echo "👉 Bạn có thể mở Capture One ngay bây giờ."
echo "💡 Để quay lại tiếng Anh gốc bất cứ khi nào, chạy: sudo ./restore_mac.sh"
