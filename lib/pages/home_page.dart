import 'package:flutter/material.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';


class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            "This is homepage",
            style: AppFonts.beVietnamMedium16.copyWith(color: AppColors.textPrimary),
          )
        ),
      ),
    );
  }

}