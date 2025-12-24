# quanlychitieu

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
-----------------------------------------------------------------------
## About App
### All Pages
#### HOME (Dashboard – Trang chính)
##### Mục đích
- Cung cấp cho người dùng cái nhìn tổng quan nhanh về tình hình tài chính cá nhân. 
##### Chức năng và nhiệm vụ
- Hiển thị lời chào người dùng
- Hiển thị tổng:
 - Thu nhập (Income)
 - Chi tiêu (Spent)
- Hiển thị biểu đồ tròn hoặc biểu đồ cột thể hiện tỷ lệ thu – chi
- Cho phép lọc dữ liệu theo thời gian:
 - All
 - Daily
 - Weekly
- Monthly
- Hiển thị danh sách giao dịch gần đây (Recent Transactions)
- Cho phép người dùng nhấn “See all” để xem toàn bộ lịch sử giao dịch

#### ADD TRANSACTION (Trang thêm giao dịch – nút +)
##### Mục đích
- Cho phép người dùng ghi nhận các khoản thu nhập hoặc chi tiêu một cách nhanh chóng và chính xác.
##### Chức năng và nhiệm vụ
- Chọn loại giao dịch:
 - Expense (Chi tiêu)
 - Income (Thu nhập)
- Nhập số tiền giao dịch
- Chọn danh mục chi tiêu hoặc thu nhập (Food, Transport, Shopping, …)
- Chọn ví hoặc phương thức thanh toán (Cash, Bank, E-wallet)
- Chọn ngày giao dịch (mặc định là ngày hiện tại)
- Nhập ghi chú (không bắt buộc)
- Lưu giao dịch và cập nhật dữ liệu cho Home, Wallet và History

#### TRANSFER (Trang chuyển tiền)
##### Mục đích
- Cho phép người dùng chuyển tiền giữa các ví hoặc tài khoản trong ứng dụng mà không làm thay đổi tổng tài sản.
##### Chức năng và nhiệm vụ
- Chọn ví nguồn (From Wallet)
- Chọn ví đích (To Wallet)
- Nhập số tiền cần chuyển
- Nút đổi chiều ví (Swap)
- Nút chuyển toàn bộ số dư (Max)
- Chọn ngày chuyển tiền
- Nhập ghi chú (không bắt buộc)
- Thực hiện chuyển tiền
- Hiển thị danh sách lịch sử các lần chuyển tiền
##### Quy tắc quan trọng
- Transfer không phải là chi tiêu
- Transfer không phải là thu nhập
- Không có category trong transfer
- Không ảnh hưởng đến biểu đồ thu – chi

#### WALLET (Trang quản lý ví)
##### Mục đích
- Quản lý các nguồn tiền của người dùng trong ứng dụng.
##### Chức năng và nhiệm vụ
- Hiển thị danh sách các ví:
 - Cash
 - Bank
 - E-wallet
- Hiển thị số dư của từng ví
- Hiển thị tổng tài sản hiện có
- Thêm ví mới
- Chỉnh sửa thông tin ví
- Xóa ví
- Xem danh sách giao dịch theo từng ví
- Đặt ví mặc định

#### TRANSACTION HISTORY (Trang lịch sử giao dịch)
##### Mục đích
Cho phép người dùng xem và quản lý toàn bộ các giao dịch đã phát sinh.
##### Chức năng và nhiệm vụ
- Hiển thị danh sách tất cả các giao dịch:
 - Expense
 - Income
 - Transfer
- Hiển thị thông tin chi tiết:
 - Số tiền
 - Category (nếu có)
 - Ngày giao dịch
 - Ví liên quan
- Cho phép lọc giao dịch theo:
 - Thời gian
 - Category
 - Loại giao dịch
- Cho phép tìm kiếm giao dịch
- Chỉnh sửa hoặc xóa giao dịch

#### PROFILE (Trang cá nhân và cài đặt)
##### Mục đích
Quản lý thông tin cá nhân và các cài đặt của ứng dụng.
#### Chức năng và nhiệm vụ
- Hiển thị thông tin người dùng:
 - Tên
 - Ảnh đại diện
- Cài đặt ứng dụng:
 - Đơn vị tiền tệ
 - Dark mode / Light mode
 - Ngôn ngữ
- Quản lý dữ liệu:
 - Xuất dữ liệu
 - Sao lưu và khôi phục
 - Reset dữ liệu
- Hiển thị thông tin ứng dụng:
 - Phiên bản
 - Gửi phản hồi

#### CATEGORY MANAGEMENT (Quản lý danh mục – tùy chọn)
##### Mục đích
Cho phép người dùng tùy chỉnh các danh mục chi tiêu và thu nhập.
##### Chức năng và nhiệm vụ
- Xem danh sách category
- Thêm category mới
- Chỉnh sửa tên, icon và màu sắc
- Xóa category
- Phân loại category:
 - Expense category
 - Income category
--------------------------------------------------------------
### All the type of transaction:
- 🍔 Food 
  - Ăn uống
  - Cafe, trà sữa
  - Ăn ngoài / ăn vặt
- 🚗 Transportation
  - Xăng xe
  - Grab / Taxi
  - Xe bus / tàu điện
- 🏠 Housing
  - Tiền nhà
  - Điện / nước
  - Internet / Wifi
- 🛒 Shopping
  - Mua sắm cá nhân
  - Quần áo
  - Đồ dùng hằng ngày
- 🎮 Entertainment
  - Game
  - Xem phim
  - Giải trí khác
- 📚 Education
  - Học phí
  - Sách
  - Khóa học online
- 💰 Income
  - Lương
  - Trợ cấp
  - Thưởng
- 💊 Healthcare
  - Thuốc
  - Khám bệnh
  - Bảo hiểm y tế
- 📦 Other
  - Chi tiêu khác
  - Không phân loại

