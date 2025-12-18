import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';

class CustomBoxItem extends StatefulWidget{
  final VoidCallback? onPressed;
  final String? title, total, description;
  final DateTime? date;
  final Widget? leftIcon, rightIcon;
  final Color? boxColor;
  const CustomBoxItem({
    super.key,
    this.onPressed,
    this.title,
    this.description,
    this.total = "0",
    this.date,
    this.leftIcon,
    this.rightIcon,
    this.boxColor
  });

  @override
  State createState() => _BoxItemState();
}

class _BoxItemState extends State<CustomBoxItem>{

  @override
  Widget build(BuildContext context) {
    String totalString = "${widget.total}\$";
    String dateString = DateFormat.yMMMd().format(widget.date!);
    return InkWell(
      onTap: widget.onPressed,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: Container(
        color: AppColors.backgroundMain,
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: (widget.boxColor)?? AppColors.mintDark,
                border: Border.all(width: 1, color: Colors.transparent),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(child: widget.leftIcon),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title!, style: AppFonts.beVietnamMedium16.
                  copyWith(color: AppColors.greyDarkest), textAlign: TextAlign.left,),
                  Text(widget.description!, style: AppFonts.beVietnamRegular12.
                  copyWith(color: AppColors.greyDark), textAlign: TextAlign.left,),
                ],
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(totalString, style: AppFonts.beVietnamMedium16.
                  copyWith(color: AppColors.greyDarkest), textAlign: TextAlign.right,),
                  Text(dateString, style: AppFonts.beVietnamRegular12.
                  copyWith(color: AppColors.greyDark), textAlign: TextAlign.right,),
                ],
              ),
            ),
            (widget.rightIcon != null)? Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.transparent),
                borderRadius: BorderRadius.circular(14),
              ),
              child: widget.rightIcon,
            ): const SizedBox(width: 4,),
          ],
        ),
      ),
    );
  }
}