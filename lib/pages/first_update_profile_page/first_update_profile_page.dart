import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quanlychitieu/services/locals/image_picker_service.dart';
import 'package:quanlychitieu/services/remote/auth%20service/auth_services.dart';
import 'package:quanlychitieu/services/remote/auth%20service/google%20auth/google_auth_service.dart';
import 'package:quanlychitieu/services/remote/errors/supabase_error_handler.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';
import 'package:quanlychitieu/utils/app_gardients.dart';
import 'package:quanlychitieu/utils/app_icons.dart';
import 'package:quanlychitieu/widgets/custom_app_button.dart';
import 'package:quanlychitieu/widgets/custom_text_field.dart';
import 'package:quanlychitieu/widgets/page_style.dart';


class FirstUpdateProfilePage extends StatefulWidget{

  const FirstUpdateProfilePage({super.key});

  @override
  State createState() => UpdateProfileState();
}


class UpdateProfileState extends State<FirstUpdateProfilePage>{
  TextEditingController? fullName = TextEditingController(text: "");
  TextEditingController? phoneNumber = TextEditingController(text: "");
  TextEditingController? birth = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  TextEditingController? address = TextEditingController(text: "");
  String? avatar_url;
  DateTime? predate = DateTime.now();
  File? selectedImage;
  final googleAuth = GoogleAuthService();

  Future<void> _pickImage() async {
    final image = await ImagePickerService.pickImageFromGallery();
    if (image == null) return;

    setState(() {
      selectedImage = image;
    });
  }


  //Get Infomation
  Future<void> getUserProfile() async{
    try{
      final profile = await googleAuth.getGoogleAcountProfile();
      if(profile != null){
        setState(() {
          fullName!.text = profile['fullName'];
          avatar_url = profile['avatar_url'];
        });
      }
    }catch (e) {
      final error = SupabaseErrorHandler.handle(e);
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message.toString())),
      );
    }
  }

  Future<void> updateUserProfile() async{
    final auth = AuthService();
    String status = "Update Profile complete!!!";
    try{
      await auth.updateUserProfile(
          fullName: fullName!.text,
          avatarUrl: null,
          phoneNumber: phoneNumber!.text,
          dateOfBirth: predate,
          address: address!.text);

    }catch (e) {
      final error = SupabaseErrorHandler.handle(e);
      print(error);
      status = error.message.toString();
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(status)),
    );
  }


  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  //Date Picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: predate,
      firstDate: DateTime(now.year - 200, now.month, now.day),
      lastDate: DateTime(now.year, now.month, now.day),
      helpText: 'Select booking date', // Optional customization
    );
    String? pickedformat = DateFormat('dd/MM/yyyy').format(picked!);
    if (pickedformat != null && pickedformat != birth!.text) {
      setState(() {
        predate = picked;
        birth!.text = pickedformat;
      });
    }
  }

  Widget? avatarBox(){
    return GestureDetector(
      onTap: _pickImage,
      child: (selectedImage != null)? Image.file(
        selectedImage!,
        width: 80, height: 80,
        fit: BoxFit.cover,
      ) : Image.network(
        avatar_url!,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const Icon(AppIcons.person, size: 80);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      widget: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            gradient: AppGradients.primary
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32,),
            Text("Check the profile here. You can change the profile as you like", textAlign: TextAlign.center,
              style: AppFonts.beVietnamRegular16.copyWith(color: Colors.white), maxLines: 2, overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8,),
            if(avatar_url != null) Align(
              alignment: Alignment.center,
              child: avatarBox()
            ),

            const SizedBox(height: 16,),
            Text(" Fullname", style: AppFonts.beVietnamRegular16.copyWith(color: Colors.white), textAlign: TextAlign.left,),
            CustomTextField(
              controller: fullName,
              fillColor: Colors.white,
              filled: true,
            ),
            const SizedBox(height: 16,),
            Text(" Phone Number", style: AppFonts.beVietnamRegular16.copyWith(color: Colors.white), textAlign: TextAlign.left,),
            CustomTextField(
              controller: phoneNumber,
              fillColor: Colors.white,
              filled: true,
            ),
            const SizedBox(height: 16,),
            Text(" Date of birth", style: AppFonts.beVietnamRegular16.copyWith(color: Colors.white), textAlign: TextAlign.left,),
            CustomTextField(
              controller: birth,
              readOnly: true,
              onTap: (){_selectDate(context);},
              suffixIcon: const Icon(AppIcons.calender, size: 16,),
              hintText: "",
              fillColor: Colors.white,
              filled: true,
            ),
            const SizedBox(height: 16,),
            Text(" Address", style: AppFonts.beVietnamRegular16.copyWith(color: Colors.white), textAlign: TextAlign.left,),
            CustomTextField(
              controller: address,
              hintText: "Address",
              fillColor: Colors.white,
              filled: true,
              maxLines: 4,
            ),
            const SizedBox(height: 32,),
            CustomAppButton(
              height: 48,
              title: "That should do it",
              borderRadius: 12,
              background: AppColors.error,
              onTap: updateUserProfile
            )
          ],
        ),
      ),
    );
  }
}