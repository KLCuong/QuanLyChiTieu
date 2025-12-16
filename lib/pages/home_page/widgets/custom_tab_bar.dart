import 'package:flutter/material.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
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
        color: AppColors.backgroundMain,
        child: SizedBox(
          height: tabH,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTab(AppIcons.home, 0),
              _buildTab(AppIcons.charChart, 1),
              const SizedBox(width: 40),
              _buildTab(AppIcons.wallet, 2),
              _buildTab(AppIcons.person, 3),
            ],
          ),
        )
      );
  }

  Widget _buildTab(IconData icon, int index){
    final isActive = (currentIndex == index);

    return IconButton(
      onPressed: () => onTabSelected(index),
      icon: Icon(
        icon, size: iconSize,
        color: isActive?
        AppColors.readStatus : AppColors.buttonDisabled,
      ),
    );
  }

}

