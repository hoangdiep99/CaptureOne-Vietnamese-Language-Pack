# 📸 Capture One Pro - Gói Tiếng Việt Chuẩn Thuật Ngữ Nhiếp Ảnh

<p align="left">
  <a href="https://github.com/hoangdiep99/CaptureOne-Vietnamese-Language-Pack/releases"><img src="https://img.shields.io/github/downloads/hoangdiep99/CaptureOne-Vietnamese-Language-Pack/total?style=for-the-badge&logo=github&color=2563eb&label=L%C6%B0%E1%BB%A3t%20t%E1%BA%A3i" alt="Lượt tải về"></a>
  <a href="https://github.com/hoangdiep99/CaptureOne-Vietnamese-Language-Pack/releases/latest"><img src="https://img.shields.io/github/v/release/hoangdiep99/CaptureOne-Vietnamese-Language-Pack?style=for-the-badge&logo=tag&color=10b981&label=Phi%C3%AAn%20b%E1%BA%A3n" alt="Phiên bản"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/Gi%E1%BA%A5y%20ph%C3%A9p-MIT-orange?style=for-the-badge" alt="License"></a>
  <img src="https://img.shields.io/badge/Capture%20One-16.x%20Pro-7c3aed?style=for-the-badge" alt="Capture One 16.x">
</p>

Bộ ngôn ngữ Tiếng Việt hoàn chỉnh, được chuẩn hóa 100% theo ngữ cảnh thực tế của nhiếp ảnh gia và retoucher chuyên nghiệp tại Việt Nam. Hỗ trợ đầy đủ cho cả **Windows** và **macOS (Intel & Apple Silicon M1/M2/M3/M4)**.

---

## ⚡ TẢI VỀ NHANH (QUICK DOWNLOADS)

| Hệ điều hành | Gói cài đặt | Tải trực tiếp | Cách cài đặt nhanh |
| :--- | :--- | :---: | :--- |
| 🪟 **Windows** *(10 / 11)* | `CaptureOne_VietHoa_Chuan_16.9.zip` | [⬇️ **Tải bản Windows (.zip)**](https://github.com/hoangdiep99/CaptureOne-Vietnamese-Language-Pack/releases/latest/download/CaptureOne_VietHoa_Chuan_16.9.zip) | Giải nén, chạy `install_windows.bat` bằng quyền Administrator |
| 🍎 **macOS** *(Intel & M1/M2/M3/M4)* | `CaptureOne_VietHoa_Mac_16.9.zip` | [⬇️ **Tải bản macOS (.zip)**](https://github.com/hoangdiep99/CaptureOne-Vietnamese-Language-Pack/releases/latest/download/CaptureOne_VietHoa_Mac_16.9.zip) | Giải nén, mở Terminal chạy `sudo ./install_mac.sh` |

> 📌 *Các bản phát hành và lịch sử cập nhật xem tại: [Danh sách Releases](https://github.com/hoangdiep99/CaptureOne-Vietnamese-Language-Pack/releases).*

---

## 🌟 Điểm nổi bật của bản dịch

- **Chuẩn hóa thuật ngữ nhiếp ảnh chuyên nghiệp**: Không dùng các từ ngữ dịch máy ngô nghê (*Cắt cúp* thay vì *Cây trồng*; *Engine xử lý* thay vì *Động cơ*; *Mô phỏng in* thay vì *Bằng chứng*; *Trái/Phải* thay vì *Mắt trái/Mắt phải*; *Bút chọn màu* thay vì *Ống nhỏ mắt*...).
- **Đầy đủ 100% giao diện hiện đại**: Hơn 10,800 chuỗi giao diện, công cụ Cursor tools, Keystone (Đường gióng & Thanh trượt), Masking, Cân bằng trắng, Xuất file...
- **Tích hợp Native**:
  - **Trên Windows**: Xuất hiện tùy chọn `Tiếng Việt (Vietnamese)` trực tiếp trong *Preferences -> General -> Language*.
  - **Trên macOS**: Tạo gói `vi.lproj` độc lập, dễ dàng chuyển đổi qua lại giữa Tiếng Anh và Tiếng Việt trong *System Settings* hoặc Terminal mà không làm hỏng ứng dụng.
- **An toàn tuyệt đối**: Không can thiệp mã nguồn độc hại, tự động sao lưu file gốc, khôi phục lại tiếng Anh chỉ với 1 click.

👉 Xem chi tiết: [Bảng đối chiếu thuật ngữ chuẩn hóa](docs/THUAT_NGU_NHIEP_ANH.md).

---

## 💻 Hướng dẫn cài đặt chi tiết

### 🍎 Dành cho macOS (macOS 12 Monterey, 13 Ventura, 14 Sonoma, 15 Sequoia+)

Hỗ trợ cả máy Mac chạy chip Intel và Apple Silicon (M1, M2, M3, M4...).

1. [Tải bản macOS](https://github.com/hoangdiep99/CaptureOne-Vietnamese-Language-Pack/releases/latest/download/CaptureOne_VietHoa_Mac_16.9.zip) và giải nén.
2. Mở ứng dụng **Terminal** trên Mac.
3. Chuyển vào thư mục vừa giải nén:
   ```bash
   cd ~/Downloads/CaptureOne_VietHoa_Mac_16.9
   ```
4. Cấp quyền và chạy script cài đặt tự động:
   ```bash
   chmod +x install_mac.sh restore_mac.sh
   sudo ./install_mac.sh
   ```
5. Nhập mật khẩu máy Mac và nhấn Enter. Script sẽ tự động chép gói `vi.lproj`, gỡ chặn bảo mật Gatekeeper (`xattr -cr`) và ký lại chứng chỉ số cho app.
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

1. [Tải bản Windows](https://github.com/hoangdiep99/CaptureOne-Vietnamese-Language-Pack/releases/latest/download/CaptureOne_VietHoa_Chuan_16.9.zip) và giải nén.
2. Nhấp chuột phải vào file **`install_windows.bat`** ➔ Chọn **Run as administrator** (Chạy với quyền Quản trị viên).
3. Script sẽ tự động:
   - Tạo bản sao lưu file gốc `P1.C1.Localization.dll.orig`.
   - Cài đặt thư viện ngôn ngữ Tiếng Việt và các file vệ tinh.
   - Kích hoạt giao diện Tiếng Việt mặc định.
4. Khởi động Capture One.

#### 🔄 Cách quay về Tiếng Anh gốc trên Windows:
- Nhấp chuột phải vào file **`restore_windows.bat`** ➔ Chọn **Run as administrator**.

---

## 🤝 Đóng góp (Contributing)

Nếu bạn phát hiện thuật ngữ nào dịch chưa sát với thực tế chụp hoặc hậu kỳ, hãy thoải mái đóng góp:
1. Fork repository này.
2. Cập nhật bản dịch trong file từ điển hoặc gửi [Issue](https://github.com/hoangdiep99/CaptureOne-Vietnamese-Language-Pack/issues) phản hồi.
3. Tạo Pull Request để chúng tôi cùng cộng đồng hoàn thiện hơn nữa!

---

## 📄 License
Phát hành dưới giấy phép mã nguồn mở [MIT License](LICENSE).  
Dự án được thực hiện phi lợi nhuận phục vụ cộng đồng nhiếp ảnh Việt Nam.
