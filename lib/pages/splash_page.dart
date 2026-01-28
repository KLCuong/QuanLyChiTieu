import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quanlychitieu/configs/supabase_keys.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';
import 'package:quanlychitieu/widgets/page_style.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../routes/app_routes.dart';

class SplashPage extends StatefulWidget{
  const SplashPage({
    super.key
  });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  void _checkAuth() async{
    await Future.delayed(const Duration(seconds: 3)); //why?
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if(!mounted) return;
    if(user != null){
      //SignIn ok
      print('User: ${user.email}');
      print('Id: ${user.id}'); //Check?
      context.go(AppRoute.home.path);
    }else{
      print('No User founded');
      context.go(AppRoute.login.path);
    }
  }

  @override
  void initState(){
    super.initState();
    _checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      widget: Container(
        margin: const EdgeInsets.all(16),
        child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: const Image(
                      image: AssetImage("assets/icons/slshizuka.jpg"),
                      width: 240,
                      height: 240,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  "Your money is gone",
                  style: AppFonts.beVietnamRegular16.copyWith(color: AppColors.greyDarkest),
                  textAlign: TextAlign.center,
                )

              ],
            )
        ),
      ),
    );
  }
}