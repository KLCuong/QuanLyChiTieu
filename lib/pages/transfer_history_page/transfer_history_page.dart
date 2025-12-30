import 'package:flutter/material.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
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
    return const CustomPage(
      widget: Center(
        child: Text("Transfer History Page"),
      )
    );
  }



}