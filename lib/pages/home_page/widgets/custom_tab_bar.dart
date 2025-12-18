import 'package:flutter/material.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';
import 'package:quanlychitieu/utils/app_icons.dart';


class CustomTabBar extends StatelessWidget{

  final int currentIndex;
  final Function(int) onTabSelected;
  final double tabH;
  final double iconSize;

  const CustomTabBar({
    super.key,
    this.currentIndex = 0,
    required this.onTabSelected,
    this.tabH = 70,
    this.iconSize = 28
  });

  @override
  Widget build(BuildContext context) {

    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        shadowColor: AppColors.backgroundLight,
        color: AppColors.backgroundMain,
        child: SizedBox(
          height: tabH,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTab(AppIcons.home, 0, "Home"),
              _buildTab(AppIcons.transfer, 1, "Transfer"),
              const SizedBox(width: 40),
              _buildTab(AppIcons.wallet, 2, "Wallet"),
              _buildTab(AppIcons.person, 3, "Profile"),
            ],
          ),
        )
      );
  }

  Widget _buildTab(IconData icon, int index, String text) {
    final isActive = (currentIndex == index);

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () => onTabSelected(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: isActive
                  ? AppColors.mintDark
                  : AppColors.mintLight,
            ),
            const SizedBox(height: 2),
            Text(
              text,
              style: AppFonts.beVietnamRegular8.copyWith(
                color: isActive
                    ? AppColors.mintDark
                    : AppColors.mintLight,
              ),
            ),
          ],
        ),
      ),
    );
  }


}

