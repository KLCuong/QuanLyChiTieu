import 'package:flutter/material.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';


class ScrollBubble extends StatefulWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  final Widget? leftIcon;

  const ScrollBubble({
    Key? key,
    this.leftIcon,
    required this.title,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  State createState() => _ScrollBubleState();
}

class _ScrollBubleState extends State<ScrollBubble>{

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: widget.isActive ? AppColors.mintDarkest : AppColors.grey,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            if(widget.leftIcon != null) widget.leftIcon!,
            Text(
              widget.title,
              style: AppFonts.beVietnamRegular14.copyWith(
                color: widget.isActive ? AppColors.greyDarkest : AppColors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        )


      ),
    );
  }
}