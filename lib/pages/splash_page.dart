import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';

import '../routes/app_routes.dart';

class SplashPage extends StatefulWidget{
  const SplashPage({
    super.key
  });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState(){
    super.initState();

    Timer(const Duration(seconds: 3),(){
      context.go(AppRoute.home.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Center(
            child: Text(
              "This is ASplashPage",
              style: AppFonts.beVietnamMedium16.copyWith(color: AppColors.textPrimary),
            )
        ),
      ),
    );
  }
}