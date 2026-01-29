import 'package:flutter/material.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';

class CustomAppButton extends StatefulWidget{
  final String? title;
  final double? width, height;
  final VoidCallback? onTap;
  final Color? background;
  final double? borderRadius;
  const CustomAppButton({
    super.key,
    required this.title,
    required this.onTap,
    this.width, this.height,
    this.borderRadius = 16,
    this.background = AppColors.mint
  });

  @override
  State createState() => ButtonAppState();
}

class ButtonAppState extends State<CustomAppButton>{
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Container(
        width: widget.width,
        height: widget.height,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius!),
            color:  widget.background
        ),
        child: Center(child: Text(
          widget.title!, style: AppFonts.beVietnamRegular16.copyWith(color: AppColors.white),
          overflow: TextOverflow.ellipsis, maxLines: 2,
        ),),
      ),
    );

  }
}