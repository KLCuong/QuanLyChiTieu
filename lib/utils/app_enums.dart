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
enum TransactionType{
  cash,
  bank,
  wallet
}

class TransactionStyle{
  final String? title;
  final AssetImage? icon;

  const TransactionStyle({
    required this.icon,
    required this.title
  });
}

class AppTranscationStyle{
  static const Map<TransactionType, TransactionStyle> styles = {
    TransactionType.cash: TransactionStyle(
        icon: AppIcons.cash_png,
        title: "Cash"
    ),
    TransactionType.wallet: TransactionStyle(
        icon: AppIcons.wallet_png,
        title: "Wallet"
    ),
    TransactionType.bank: TransactionStyle(
        icon: AppIcons.bank_png,
        title: "Bank"
    ),
  };
}
