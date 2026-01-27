import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quanlychitieu/routes/app_routes.dart';
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
  bool _isLogin = true;
  String buttontitle = "Login";

  void showPassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void OnLoginTap(){
    context.push(AppRoute.home.path);
  }

  void getToSignUp(){
    setState(() {
      _isLogin = !_isLogin;
      if(_isLogin == true) buttontitle = "Login";
      else buttontitle = "Sign up";
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
              if(!_isLogin)...[
                const SizedBox(height: 16,),
                CustomTextField(
                    hintText: "Fullname",
                    filled: true,
                    fillColor: AppColors.white,
                    controller: fullname,
                ),
              ]else...[
                const SizedBox(height: 8,),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
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
                onTap: OnLoginTap,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an acount?  ",
                    style: AppFonts.beVietnamRegular14.copyWith(color: AppColors.white),
                  ),
                  GestureDetector(
                    onTap: getToSignUp,
                    child: Text( "Sign up here",style: AppFonts.beVietnamMedium16.copyWith(color: AppColors.white,
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
                          onTap: (){print("Ckick");},
                          child: const Image(
                            image: AppIcons.gmail_png,
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