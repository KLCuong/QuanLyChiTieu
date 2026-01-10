import 'package:flutter/material.dart';
import 'package:quanlychitieu/utils/app_icons.dart';
import 'app_colors.dart';

//For app category
enum CategoryType {
  food,
  transport,
  shopping,
  entertainment,
  housing,
  education,
  transfer,
  income,
  healthcare,
  other,
}

class CategoryStyle {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  const CategoryStyle({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });
}

class AppCategoryStyle {
  static const Map<CategoryType, CategoryStyle> styles = {
    CategoryType.food: CategoryStyle(
      icon: AppIcons.food,
      backgroundColor: AppColors.orangeVeryLight,
      iconColor: AppColors.orangeDark,
    ),

    CategoryType.transport: CategoryStyle(
      icon: AppIcons.transport,
      backgroundColor: AppColors.blueVeryLight,
      iconColor: AppColors.blueDark,
    ),

    CategoryType.shopping: CategoryStyle(
      icon: AppIcons.shopping,
      backgroundColor: AppColors.pinkVeryLight,
      iconColor: AppColors.pinkDark,
    ),

    CategoryType.entertainment: CategoryStyle(
      icon: AppIcons.entertainment,
      backgroundColor: AppColors.purpleVeryLight,
      iconColor: AppColors.purpleDark,
    ),

    CategoryType.housing: CategoryStyle(
      icon: AppIcons.housing,
      backgroundColor: AppColors.mintVeryLight,
      iconColor: AppColors.mintDark,
    ),

    CategoryType.education: CategoryStyle(
      icon: AppIcons.education,
      backgroundColor: AppColors.yellowVeryLight,
      iconColor: AppColors.yellowDark,
    ),

    CategoryType.transfer: CategoryStyle(
      icon: AppIcons.transfer,
      backgroundColor: AppColors.greyVeryLight,
      iconColor: AppColors.greyDark,
    ),

    CategoryType.income: CategoryStyle(
      icon: AppIcons.income,
      backgroundColor: AppColors.mintLight,
      iconColor: AppColors.mintDarkest,
    ),

    CategoryType.healthcare: CategoryStyle(
      icon: AppIcons.healthcare,
      backgroundColor: AppColors.pinkVeryLight,
      iconColor: AppColors.error,
    ),

    CategoryType.other: CategoryStyle(
      icon: AppIcons.other,
      backgroundColor: AppColors.greyVeryLight,
      iconColor: AppColors.greyDarkest,
    ),
  };
}

//For transcations change
enum TransferType{
  cash,
  bank,
  wallet
}

class TransferStyle{
  final String? title;
  final AssetImage? icon;
  final Color? bgcolor;

  const TransferStyle({
    required this.icon,
    required this.title,
    this.bgcolor = AppColors.white
  });
}

class AppTransferStyle{
  static const Map<TransferType, TransferStyle> styles = {
    TransferType.cash: TransferStyle(
        icon: AppIcons.cash_png,
        title: "Cash",
        bgcolor: AppColors.mint
    ),
    TransferType.wallet: TransferStyle(
        icon: AppIcons.wallet_png,
        title: "E-Wallet",
        bgcolor: AppColors.blueLight
    ),
    TransferType.bank: TransferStyle(
        icon: AppIcons.bank_png,
        title: "Bank",
        bgcolor: AppColors.purple
    ),
  };
}
