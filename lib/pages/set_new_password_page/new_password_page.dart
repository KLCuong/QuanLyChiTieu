import 'package:flutter/material.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';
import 'package:quanlychitieu/utils/app_gardients.dart';
import 'package:quanlychitieu/utils/app_icons.dart';
import 'package:quanlychitieu/widgets/custom_app_button.dart';
import 'package:quanlychitieu/widgets/custom_text_field.dart';
import 'package:quanlychitieu/widgets/page_style.dart';

class NewPasswordPage extends StatefulWidget{

  const NewPasswordPage({super.key});

  @override
  State createState() => NewPassState();
}

class NewPassState extends State<NewPasswordPage>{
  TextEditingController? password = TextEditingController(text: "");
  TextEditingController? passwordconfirm = TextEditingController(text: "");
  bool _obscureText = true, _obscureText2 = true;
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
              Text("Reset password", style: AppFonts.beVietnamMedium18
                  .copyWith(color: AppColors.white), textAlign: TextAlign.center,),
              Text("Please set your new password", style: AppFonts.beVietnamRegular12
                  .copyWith(color: AppColors.white), textAlign: TextAlign.center,),
              const SizedBox(height: 32,),
              const SizedBox(height: 16,),
              Text(" New password", style: AppFonts.beVietnamRegular16.copyWith(color: Colors.white), textAlign: TextAlign.left,),
              CustomTextField(
                  hintText: "Enter new password here",
                  filled: true,
                  fillColor: AppColors.white,
                  controller: password,
                  obscureText: _obscureText,
                  suffixIcon: GestureDetector(
                    onTap: (){
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: const Icon(AppIcons.showpassword, size: 16,),
                  )
              ),
              const SizedBox(height: 16,),
              Text(" Confirm password", style: AppFonts.beVietnamRegular16.copyWith(color: Colors.white), textAlign: TextAlign.left,),
              CustomTextField(
                  hintText: "Enter new password here",
                  filled: true,
                  fillColor: AppColors.white,
                  controller: passwordconfirm,
                  obscureText: _obscureText2,
                  suffixIcon: GestureDetector(
                    onTap: (){
                      setState(() {
                        _obscureText2 = !_obscureText2;
                      });
                    },
                    child: const Icon(AppIcons.showpassword, size: 16,),
                  )
              ),
              const SizedBox(height: 32,),
              CustomAppButton(
                  height: 48,
                  title: "Set new password",
                  borderRadius: 12,
                  background: AppColors.mint,
                  onTap: (){}
              )
            ]
        ),
      ),
    );
  }
}