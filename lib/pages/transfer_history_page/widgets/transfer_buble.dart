import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_enums.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';
import 'package:quanlychitieu/utils/app_icons.dart';

class TransferBubble extends StatefulWidget{
  final TransferType? fromT, toT;
  final DateTime? date;
  final String? amount;

  const TransferBubble({
    super.key,
    required this.fromT,
    required this.toT,
    required this.amount,
    required this.date
  });

  @override
  State createState() => _TransferBState();
}

class _TransferBState extends State<TransferBubble>{

  Widget FromToWidget(){
    return Row(
      children: [
        if(widget.fromT != null) ...[
          Image(image: AppTransferStyle.styles[widget.fromT]!.icon!,
            width: 24, height: 24,),
          const SizedBox(width: 4,),
          Text(AppTransferStyle.styles[widget.fromT]!.title ?? "",
            style: AppFonts.beVietnamRegular14.
            copyWith(color: AppColors.greyDarkest),
          )
        ],
        const SizedBox(width: 4,),
        const Icon(AppIcons.arrowForward, size: 22,),
        const SizedBox(width: 4,),
        if(widget.toT != null) ...[
          Image(image: AppTransferStyle.styles[widget.toT]!.icon!,
            width: 24, height: 24,),
          const SizedBox(width: 4,),
          Text(AppTransferStyle.styles[widget.fromT]!.title ?? "",
            style: AppFonts.beVietnamRegular14.
            copyWith(color: AppColors.greyDarkest),
          )
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.greyVeryLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FromToWidget(),
              Text("${widget.amount} \$", style: AppFonts.beVietnamRegular14.
                copyWith(color: AppColors.blue), textAlign: TextAlign.end,),
            ],
          ),
          const SizedBox(height: 8,),
          Text(DateFormat('dd/MM/yyyy').format(widget.date!),
            style: AppFonts.beVietnamRegular14.copyWith(color: AppColors.grey),
          )
        ],
      ),
    );
  }
}