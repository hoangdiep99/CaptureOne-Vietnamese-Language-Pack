# 🇻🇳 Capture One Pro - Gói Tiếng Việt Chuẩn Thuật Ngữ Nhiếp Ảnh

[![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20macOS-blue.svg)](https://github.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/Capture%20One-16.x%20Pro-green.svg)](https://www.captureone.com/)

Bộ ngôn ngữ Tiếng Việt hoàn chỉnh, được chuẩn hóa 100% theo ngữ cảnh thực tế của nhiếp ảnh gia và retoucher chuyên nghiệp tại Việt Nam. Hỗ trợ đầy đủ cả hai hệ điều hành **Windows** và **macOS (Intel & Apple Silicon M1/M2/M3/M4)**.

---

## 📸 Điểm nổi bật của bản dịch

- **Chuẩn hóa thuật ngữ nhiếp ảnh chuyên nghiệp**: Không dùng các từ ngữ dịch máy ngô nghê (*Cắt cúp* thay vì *Cây trồng*; *Engine xử lý* thay vì *Động cơ*; *Mô phỏng in* thay vì *Bằng chứng*; *Trái/Phải* thay vì *Mắt trái/Mắt phải*; *Bút chọn màu* thay vì *Ống nhỏ mắt*...).
- **Đầy đủ 100% giao diện hiện đại**: Hơn 10,800 chuỗi giao diện, công cụ Cursor tools, Keystone (Đường gióng & Thanh trượt), Masking, Cân bằng trắng, Xuất file...
- **Tích hợp Native**:
  - **Trên Windows**: Xuất hiện tùy chọn `Tiếng Việt (Vietnamese)` trực tiếp trong *Preferences -> General -> Language*.
  - **Trên macOS**: Tạo gói `vi.lproj` độc lập, dễ dàng chuyển đổi qua lại giữa Tiếng Anh và Tiếng Việt trong *System Settings* hoặc Terminal mà không làm hỏng ứng dụng.
- **An toàn tuyệt đối**: Không can thiệp mã nguồn độc hại, tự động sao lưu file gốc, khôi phục lại tiếng Anh chỉ với 1 click.

👉 Xem chi tiết: [Bảng đối chiếu thuật ngữ chuẩn hóa](docs/THUAT_NGU_NHIEP_ANH.md).

---

## 💻 Hướng dẫn cài đặt

### 🍎 Dành cho macOS (macOS 12 Monterey, 13 Ventura, 14 Sonoma, 15 Sequoia+)

Hỗ trợ cả máy Mac chạy chip Intel và Apple Silicon (M1, M2, M3, M4...).

1. Tải về thư mục này về máy Mac.
2. Mở ứng dụng **Terminal** trên Mac.
3. Chuyển vào thư mục `macos`:
   ```bash
   cd path/to/CaptureOne-Vietnamese-Language-Pack/macos
   ```
4. Cấp quyền và chạy script cài đặt tự động:
   ```bash
   chmod +x install_mac.sh restore_mac.sh
   sudo ./install_mac.sh
   ```
5. Nhập mật khẩu máy Mac và nhấn Enter. Script sẽ tự động chép ngôn ngữ, gỡ chặn bảo mật Gatekeeper và ký lại chứng chỉ số cho app.
6. Mở Capture One và tận hưởng giao diện Tiếng Việt!

#### 🔄 Cách chuyển đổi ngôn ngữ trên Mac:
- **Về Tiếng Anh**:
  ```bash
  defaults write com.captureone.captureone16 AppleLanguages '("en")'
  ```
- **Bật lại Tiếng Việt**:
  ```bash
  defaults write com.captureone.captureone16 AppleLanguages '("vi")'
  ```
- **Gỡ bỏ hoàn toàn**:
  ```bash
  sudo ./restore_mac.sh
  ```

---

### 🪟 Dành cho Windows (Windows 10, Windows 11)

1. Tải về hoặc giải nén thư mục dự án.
2. Mở thư mục `windows`.
3. Nhấp chuột phải vào file **`install_windows.bat`** ➔ Chọn **Run as administrator** (Chạy với quyền Quản trị viên).
4. Script sẽ tự động:
   - Tạo bản sao lưu file gốc `P1.C1.Localization.dll.orig`.
   - Cài đặt thư viện ngôn ngữ Tiếng Việt và các file vệ tinh.
   - Kích hoạt giao diện Tiếng Việt mặc định.
5. Khởi động Capture One.

#### 🔄 Cách quay về Tiếng Anh gốc trên Windows:
- Nhấp chuột phải vào file **`windows/restore_windows.bat`** ➔ Chọn **Run as administrator**.

---

## 🤝 Đóng góp (Contributing)

Nếu bạn phát hiện thuật ngữ nào dịch chưa sát với thực tế chụp hoặc hậu kỳ, hãy thoải mái đóng góp:
1. Fork repository này.
2. Cập nhật bản dịch trong file từ điển hoặc gửi [Issue](https://github.com/) phản hồi.
3. Tạo Pull Request để chúng tôi cùng cộng đồng hoàn thiện hơn nữa!

---

## 📄 License
Phát hành dưới giấy phép mã nguồn mở [MIT License](LICENSE).
Tất cả các nhãn hiệu thương mại thuộc về Capture One A/S. Dự án được thực hiện phi lợi nhuận phục vụ cộng đồng nhiếp ảnh Việt Nam.
