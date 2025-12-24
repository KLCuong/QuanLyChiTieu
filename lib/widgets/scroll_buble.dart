import 'package:flutter/material.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';


class ScrollBubble extends StatefulWidget {
  final String title;
  final bool isActive, marginRight;
  final VoidCallback onTap;
  final Widget? leftIcon, rightIcon;

  const ScrollBubble({
    Key? key,
    this.leftIcon,
    this.rightIcon,
    this.marginRight = true,
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
    EdgeInsets padding = EdgeInsets.fromLTRB(
      24,
      8,
      widget.rightIcon != null ? 16 : 24,
      8,
    );

    return InkWell(
      onTap: widget.onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Row(
        children: [
          Container(
              padding: padding,
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
                  const SizedBox(width: 8,),
                  if(widget.rightIcon != null) widget.rightIcon!,
                ],
              )
          ),
          if(widget.marginRight == true) const SizedBox(width: 8),
        ],
      )



    );
  }
}