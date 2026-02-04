import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quanlychitieu/models/user_profile.dart';
import 'package:quanlychitieu/pages/wallet_page/widgets/walletbox.dart';
import 'package:quanlychitieu/services/remote/wallet_service/wallet_services.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_enums.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';
import 'package:quanlychitieu/utils/app_gardients.dart';
import 'package:quanlychitieu/utils/app_icons.dart';

class WalletPage extends StatefulWidget{
  final UserProfile? userProfile;
  const WalletPage({
    super.key,
    this.userProfile
  });

  @override
  State createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage>{
  final walletService = WalletService();
  String totalAmount = "0";
  bool _isLoading = true;


  void getTotalAmount() async{
   final amount = await walletService.getTotalAmount();
   if(amount != null){
     setState(() {
       totalAmount = amount.toString();
       _isLoading = false;
     });
   }
  }

  Future<void> reloadWalletPage() async {
    setState(() {
      _isLoading = true;
    });
    getTotalAmount();
  }


  Widget TotalBalanceBox(){
    return Container(
      padding: const EdgeInsets.fromLTRB(16,16,16,24),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppGradients.box,
        borderRadius: BorderRadius.circular(16),
      ),
      child: (_isLoading)? const Center(child: CircularProgressIndicator()):
      Row(
        children: [
          Container(
            width: 48, height: 48,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(AppIcons.wallet, size: 28, color: AppColors.white,),
          ),
          const SizedBox(width: 12,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Total Balance", textAlign: TextAlign.start,
                style: AppFonts.beVietnamRegular14.copyWith(color: AppColors.white),
              ),
              RichText(
                text: TextSpan(
                  text: totalAmount,
                  style: AppFonts.robotoMedium32.copyWith(color: AppColors.white),
                  children: [
                    TextSpan(
                      text: "\$",
                      style: AppFonts.beVietnamMedium14.copyWith(color: AppColors.white),
                    )
                  ]
                ),
                textAlign: TextAlign.start,

              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    getTotalAmount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          color: AppColors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Wallets", textAlign: TextAlign.start,
                style: AppFonts.beVietnamSemiBold18
                    .copyWith(color: AppColors.greyDarkest),
              ),
              Text(
                "Manage your money sources", textAlign: TextAlign.start,
                style: AppFonts.beVietnamRegular16
                    .copyWith(color: AppColors.greyDark),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4, bottom: 16),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TotalBalanceBox(),
              const SizedBox(height: 16,),
              WalletBox(
                type: TransferType.cash,
                onUpdated: reloadWalletPage,
              ),
              WalletBox(
                type: TransferType.bank,
                onUpdated: reloadWalletPage,
              ),
              WalletBox(
                type: TransferType.wallet,
                onUpdated: reloadWalletPage,
              ),
            ],
          ),
        )
      ],
    );
  }
}