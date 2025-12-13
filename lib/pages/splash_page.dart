import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quanlychitieu/routes/app_router.dart';

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
      print("done");
      context.go(AppRoute.home.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}