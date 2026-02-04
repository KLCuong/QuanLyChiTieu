import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quanlychitieu/models/user_profile.dart';
import 'package:quanlychitieu/routes/app_routes.dart';
import 'package:quanlychitieu/services/remote/auth service/auth_services.dart';
import 'package:quanlychitieu/services/remote/errors/supabase_error_handler.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';
import 'package:quanlychitieu/utils/app_gardients.dart';
import 'package:quanlychitieu/utils/app_icons.dart';
import 'package:quanlychitieu/widgets/custom_app_button.dart';
import 'package:quanlychitieu/widgets/custom_text_field.dart';
import 'package:quanlychitieu/widgets/page_style.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>{
  TextEditingController? username = TextEditingController(text: "");
  TextEditingController? password = TextEditingController(text: "");
  TextEditingController? fullname = TextEditingController(text: "");
  bool _obscureText = true;
  int type = 0;
  // 0 - login
  // 1 - signup
  // 2 - forgot password
  String buttontitle = "Login";

  final AuthService _authService = AuthService();

  void showPassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool checkingValid(){
    String email = username!.text.trim();
    String pass = password!.text.trim();
    if(email == '' || pass == ''){
      return false;
    }else {
      return true;
    }
  }

  void onGoogleTouch() async{
    try{
      final user = await _authService.signInWithGoogle();
      if (user != null) {
        final profile = await _authService.getUserProfile();
        if(profile != null) {
          context.go(AppRoute.home.path);
        } else {
          context.go(AppRoute.update_profile.path);
        }
        //context.go(AppRoute.home.path);
      }
    }catch  (e) {
      final error = SupabaseErrorHandler.handle(e);
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message.toString())),
      );
    }
  }

  void OnConfirmButtonTap() async{
    try{
      if (type == 0) {
        //On login session
        bool check = checkingValid();
        if(check == false){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please fill your username and password")),
          );
        }else{
          await _authService.login(
              email: username!.text.trim(),
              password: password!.text.trim()
          );
          final user = _authService.currentUser;
          if(user!.id != null) context.go(AppRoute.home.path);
        }
      } else if(type == 1) {
        //On signup session
        await _authService.signUp(
          email: username!.text.trim(),
          password: password!.text.trim(),
          fullName: fullname!.text.trim(),
        );
        final user = _authService.currentUser;
        if(user!.id != null) context.go(AppRoute.home.path);
      }else if(type == 2){
        //On request password session
        String? req_email = username!.text.trim();
        if(req_email != null) {
          context.pushNamed(AppRoute.otp.name, extra: req_email);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please enter the correct email"),)
          );
        }
      }
      if (!mounted) return;

    }catch (e) {
      final error = SupabaseErrorHandler.handle(e);
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message.toString())),
      );
    }

  }

  void getToSignUp(){
    setState(() {
      if(type == 0) {
        type = 1;
        buttontitle = "Sign up";
      }else {
        type = 0;
        buttontitle = "Login";
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return CustomPage(
        widget: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              gradient: AppGradients.fun
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 48,),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: AppColors.white.withOpacity(0.3),
                ),
                padding: const EdgeInsets.all(16),
                width: 84,
                height: 84,
                child: const Image(image: AppIcons.wallet_png,)
              ),
              Text("Welcome back to my app", style: AppFonts.beVietnamMedium18
                    .copyWith(color: AppColors.white), textAlign: TextAlign.center,),
              Text("Login to start managing", style: AppFonts.beVietnamRegular12
                    .copyWith(color: AppColors.white), textAlign: TextAlign.center,),
              const SizedBox(height: 32,),
              if(type != 2)...[
                CustomTextField(
                  filled: true,
                  hintText: "Username",
                  fillColor: AppColors.white,
                  controller: username,
                ),
                const SizedBox(height: 16,),
                CustomTextField(
                    hintText: "Password",
                    filled: true,
                    fillColor: AppColors.white,
                    controller: password,
                    obscureText: _obscureText,
                    suffixIcon: GestureDetector(
                      onTap: showPassword,
                      child: const Icon(AppIcons.showpassword, size: 16,),
                    )
                ),
              ]else ...[
                CustomTextField(
                    hintText: "Email",
                    filled: true,
                    fillColor: AppColors.white,
                    controller: username,
                ),
              ],

              if(type == 1)...[
                const SizedBox(height: 16,),
                CustomTextField(
                    hintText: "Fullname",
                    filled: true,
                    fillColor: AppColors.white,
                    controller: fullname,
                ),
              ]else if(type == 0)...[
                const SizedBox(height: 8,),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        type = 2;
                        buttontitle = "Get verify email";
                      });
                    },
                    child: Text(
                      "Forgot password?", style: AppFonts.beVietnamRegular14
                        .copyWith(color: AppColors.white),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 32,),
              CustomAppButton(
                width: double.infinity,
                height: 48,
                title: buttontitle,
                onTap: OnConfirmButtonTap,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text((type == 0)?"Don't have an acount?  ": "Already have an account?  ",
                    style: AppFonts.beVietnamRegular14.copyWith(color: AppColors.white),
                  ),
                  GestureDetector(
                    onTap: getToSignUp,
                    child: Text( (type == 0)?"Sign up here": "Sign in here",
                        style: AppFonts.beVietnamMedium16.copyWith(color: AppColors.white,
                        decoration: TextDecoration.underline, decorationColor: AppColors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 24,),
              Center(child: Text("_____Try another way_____",style: AppFonts.beVietnamRegular14
                    .copyWith(color: AppColors.white),),),
              const SizedBox(height: 12,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                        padding: const EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: onGoogleTouch,
                          child: const Image(
                            image: AppIcons.google_png,
                            width: 36, height: 36,
                          ),
                        )
                  ),
                ],
              ),




            ]
          ),
        ),
    );
  }
}