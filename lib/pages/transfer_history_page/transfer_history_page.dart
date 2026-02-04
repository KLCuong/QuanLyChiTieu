import 'package:flutter/material.dart';
import 'package:quanlychitieu/models/transfer.dart';
import 'package:quanlychitieu/pages/transfer_history_page/widgets/transfer_buble.dart';
import 'package:quanlychitieu/services/remote/errors/supabase_error_handler.dart';
import 'package:quanlychitieu/services/remote/transfer_service/transfer_services.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_enums.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';
import 'package:quanlychitieu/widgets/page_style.dart';


class TransferHistoryPage extends StatefulWidget{

  const TransferHistoryPage({
    super.key
  });

  @override
  State createState() => TransHisState();
}

class TransHisState extends State<TransferHistoryPage>{
  final transferService = TransferService();
  List<Transfer> _transfers = [];
  bool _isLoading = true;

  @override
  void initState() {
    _loadTransfers();
    super.initState();
  }

  Future<void> _loadTransfers() async {
    try {
      final result = await transferService.getTransferList();
      setState(() {
        _transfers = result;
        _isLoading = false;
      });
    } catch (e) {
      _isLoading = false;
      final error = SupabaseErrorHandler.handle(e);
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message.toString())),
      );
    }
    }

  TransferType parseTransferType(String type){
    switch(type.toLowerCase()){
      case "e-wallet":
        return TransferType.wallet;
      case "cash":
        return TransferType.cash;
      case "bank":
        return TransferType.bank;
      default:
        return TransferType.wallet;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPage(
        hasAppBar: true,
        pageName: "All transfer history",
        widget: Container(
          padding: const EdgeInsets.all(16),
          child: (_isLoading)? const Center(child: CircularProgressIndicator(),):
          ListView(
            children: [
              Text("Recent transfers",
                style: AppFonts.beVietnamRegular16.
                copyWith(color: AppColors.greyDarkest),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 16,),
              (_transfers.isEmpty)? const Text("No transfer so far") :
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ..._transfers.map((transfer) {
                    return TransferBubble(
                      fromT: parseTransferType(transfer.fromWallet),
                      toT: parseTransferType(transfer.fromWallet),
                      amount: transfer.amount.toString(),
                      date: transfer.createdAt,
                    );
                  }).toList(),
                ],
              )
            ],
          ),
        )
    );
  }


}