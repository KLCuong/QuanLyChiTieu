import 'package:flutter/material.dart';
import 'package:quanlychitieu/pages/transfer_history_page/widgets/transfer_buble.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_enums.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';
import 'package:quanlychitieu/widgets/page_style.dart';


class TransferHistoryPage extends StatefulWidget{

  const TransferHistoryPage({
    super.key
  });

  @override
  State createState() => _TransHisState();
}

class _TransHisState extends State<TransferHistoryPage>{


  @override
  Widget build(BuildContext context) {
    return CustomPage(
      hasAppBar: true,
      pageName: "All transfer history",
      widget: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text("Recent transfers",
              style: AppFonts.beVietnamRegular16.
              copyWith(color: AppColors.greyDarkest),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 16,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TransferBubble(
                    fromT: TransferType.cash,
                    toT: TransferType.bank,
                    amount: "100.000.000",
                    date: DateTime.now()
                )
              ],
            )
          ],
        ),
      )
    );
  }



}