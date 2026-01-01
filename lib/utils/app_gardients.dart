import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppGradients {
  AppGradients._(); // prevent init

  /// 🔵 Primary – Blue
  static const LinearGradient primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.blueLight,
      AppColors.blue,
      //AppColors.blueDarkest,
    ],
  );

  /// 🟠 Warm – Orange
  static const LinearGradient warm = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.orangeLight,
      AppColors.orange,
      AppColors.orangeDarkest,
    ],
  );

  /// 🟣 Fun – Purple
  static const LinearGradient fun = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.purpleLight,
      AppColors.purple,
      AppColors.purpleDarkest,
    ],
  );

  /// 🟢 Calm – Mint
  static const LinearGradient calm = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.mintLight,
      AppColors.mint,
      AppColors.mintDarkest,
    ],
  );

  static const LinearGradient box = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.blue,
      AppColors.purple,
    ],
  );
}
