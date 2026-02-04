import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quanlychitieu/services/remote/wallet_service/wallet_services.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_enums.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';
import 'package:quanlychitieu/utils/app_icons.dart';

class WalletBox extends StatefulWidget{
  final TransferType? type;
  final VoidCallback? onUpdated;
  const WalletBox({
    super.key,
    required this.type,
    this.onUpdated,
  });

  @override
  State createState() => _WalletBoxState();
}

class _WalletBoxState extends State<WalletBox>{
  double amount = 0;
  bool _isLoading = true;
  final walletService = WalletService();

  Widget IconBox(){
    return Container(
      width: 48, height: 48,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppTransferStyle.styles[widget.type]!.bgcolor!,
      ),
      child: Image(image: AppTransferStyle.styles[widget.type]!.icon!),
    );
  }

  void showUpdateDialog() {
    final TextEditingController nameController =
    TextEditingController(text: AppTransferStyle.styles[widget.type]!.title!);
    final TextEditingController balanceController =
    TextEditingController(text: amount.toString());

    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(
          'Edit Wallet', style: AppFonts.beVietnamSemiBold14.
            copyWith(color: AppColors.greyDarkest),
          textAlign: TextAlign.start
        ),
        content: Container(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            children: [
              // Wallet Name
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Wallet Name', style: AppFonts.beVietnamRegular14.
                  copyWith(color: AppColors.greyDarkest),
                ),
              ),
              const SizedBox(height: 6),
              CupertinoTextField(
                controller: nameController,
                placeholder: 'Wallet name',
                readOnly: true,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 8),
              // Initial Balance
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Initial Balance', style: AppFonts.beVietnamRegular14.
                  copyWith(color: AppColors.greyDarkest),
                ),
              ),
              const SizedBox(height: 6),
              CupertinoTextField(
                controller: balanceController,
                keyboardType: TextInputType.number,
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text('\$'),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel', style: AppFonts.beVietnamRegular14,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Save', style: AppFonts.beVietnamRegular14,),
            onPressed: () {
              final name = nameController.text.trim();
              final balance = double.parse(balanceController.text.trim());
              updateWallet(balance, nameController.text.toLowerCase());
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
  void updateWallet(double newBalance, String type)async{
    await walletService.updateWalletBalance(walletType: type, newTotal: newBalance);
    getDirectAmount();
    widget.onUpdated?.call();
  }

  void getDirectAmount() async{
    String typ = AppTransferStyle.styles[widget.type]!.title!;
    final total = await walletService.getWalletBalance(typ.toLowerCase());
    if(total != null){
      setState(() {
        amount = total;
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getDirectAmount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
      ),
      child: (_isLoading)? const Center(child: CircularProgressIndicator(),) :
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,

        children: [
          IconBox(),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppTransferStyle.styles[widget.type]!.title!, style: AppFonts.beVietnamRegular14.
                copyWith(color: AppColors.greyDarkest), textAlign: TextAlign.start,),
                // Text('5 transactions', style: AppFonts.beVietnamRegular12.
                // copyWith(color: AppColors.grey), textAlign: TextAlign.start,),
                Text(amount.toString(), style: AppFonts.beVietnamRegular16.
                copyWith(color: AppColors.greyDarkest), textAlign: TextAlign.start,),
              ],
            ),
          ),
          InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: showUpdateDialog,
            child: const Icon(AppIcons.edit, size: 16, color: AppColors.grey,),
          ),

        ],
      ),
    );
  }
}

