import 'package:flutter/material.dart';

class AppColors {
  // =========================
  // BRAND COLORS
  // =========================

  /// Màu chính (Primary)
  /// Dùng cho: AppBar, Button chính, Icon active, Link
  static const Color primary = Color(0xFF1976D2);

  /// Màu phụ (Secondary / Accent)
  /// Dùng cho: highlight, CTA phụ, switch, indicator
  static const Color secondary = Color(0xFF42A5F5);

  /// Accent nhạt
  /// Dùng cho: hover, splash, background phụ
  static const Color accentLight = Color(0xFF90CAF9);

  /// Accent đậm
  /// Dùng cho: pressed state, focus
  static const Color accentDark = Color(0xFF1565C0);

  // =========================
  // BACKGROUND COLORS
  // =========================

  /// Nền chính của app
  static const Color backgroundMain = Color(0xFFFBFBFB);

  /// Nền sáng (list, card)
  static const Color backgroundLight = Color(0xFFF5F5F5);

  /// Nền tối (dark mode)
  static const Color backgroundDark = Color(0xFF121212);

  /// Nền cho input, text box
  static const Color textBoxBackground = Color(0xFFF2F2F2);

  /// Nền card
  static const Color cardBackground = Color(0xFFFFFFFF);

  // =========================
  // TEXT COLORS
  // =========================

  /// Văn bản chính
  static const Color textPrimary = Color(0xFF212121);

  /// Văn bản phụ
  static const Color textSecondary = Color(0xFF757575);

  /// Text disabled / hint
  static const Color textHint = Color(0xFF9E9E9E);

  /// Text trên nền tối
  static const Color textWhite = Colors.white;

  // =========================
  // BORDER & DIVIDER
  // =========================

  /// Viền xám nhẹ
  static const Color greyBorder = Color(0x39808081);

  /// Viền mặc định
  static const Color border = Color(0xFFE0E0E0);

  /// Divider
  static const Color divider = Color(0xFFEEEEEE);

  // =========================
  // CHAT / MESSAGE
  // =========================

  /// Bong bóng tin nhắn của tôi
  static const Color myMessageBubble = Color(0xFFDCF8C6);

  /// Bong bóng tin nhắn người khác
  static const Color otherMessageBubble = Color(0xFFFFFFFF);

  // =========================
  // MESSAGE STATUS
  // =========================

  /// Đã gửi
  static const Color sentStatus = Color(0xFF4CAF50);

  /// Đã nhận
  static const Color deliveredStatus = Color(0xFF2196F3);

  /// Đã đọc
  static const Color readStatus = Color(0xFF673AB7);

  // =========================
  // BUTTON & INPUT
  // =========================

  /// Button chính
  static const Color buttonPrimary = primary;

  /// Button phụ
  static const Color buttonSecondary = secondary;

  /// Button disabled
  static const Color buttonDisabled = Color(0xFFBDBDBD);

  /// Nền input
  static const Color inputBackground = Color(0xFFF0F0F0);

  // =========================
  // SYSTEM COLORS
  // =========================

  /// Lỗi
  static const Color error = Color(0xFFD32F2F);

  /// Thành công
  static const Color success = Color(0xFF388E3C);

  /// Cảnh báo
  static const Color warning = Color(0xFFFBC02D);

  /// Thông tin
  static const Color info = Color(0xFF0288D1);

  // =========================
  // OVERLAY & SHADOW
  // =========================

  /// Overlay mờ (dialog, modal)
  static const Color overlay = Color(0x80000000);

  /// Shadow nhẹ
  static const Color shadow = Color(0x1F000000);
}
