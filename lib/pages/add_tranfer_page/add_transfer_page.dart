import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:quanlychitieu/pages/splash_page.dart';
import 'package:quanlychitieu/routes/app_routes.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_enums.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';
import 'package:quanlychitieu/utils/app_icons.dart';
import 'package:quanlychitieu/widgets/custom_text_field.dart';
import 'package:quanlychitieu/widgets/scroll_buble.dart';


class AddTranferPage extends StatefulWidget{

  const AddTranferPage({
    super.key,
  });

  @override
  State createState() => _AddTranferState();
}

class _AddTranferState extends State<AddTranferPage>{
  TextEditingController? fromWallet = TextEditingController(text: "Cash");
  TextEditingController? toWallet = TextEditingController(text: "Bank");
  TextEditingController? amount = TextEditingController(text: "0");
  TextEditingController? date = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  TextEditingController? note = TextEditingController(text: "");

  TransferType? selectedFromWallet = TransferType.cash;
  TransferType? selectedToWallet = TransferType.bank;

  String? availableFrom = "100 VND";
  String? availableTo = "0 VND";

  //Date Picker
  DateTime? predate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: predate,
      firstDate: DateTime(now.year - 3, now.month, now.day),
      lastDate: DateTime(now.year, now.month, now.day),
      helpText: 'Select booking date', // Optional customization
    );
    String? pickedformat = DateFormat('dd/MM/yyyy').format(picked!);
    if (pickedformat != null && pickedformat != date!.text) {
      setState(() {
        predate = picked;
        date!.text = pickedformat;
      });
    }
  }

  Widget confirmButton(){
    return InkWell(
      onTap: (){},
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.fromLTRB(32, 20, 32, 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.mintDarkest, width: 1),
            borderRadius: BorderRadius.circular(16),
            color: AppColors.mintDark
        ),
        child: Center(
          child: Text(
            "Transfer", textAlign: TextAlign.center,
            style: AppFonts.beVietnamRegular16.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }

  void showPopupMenu(
      BuildContext context,
      TextEditingController? controller,
      TransferType? currentType,
      bool? from
      ) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: AppColors.greyLight, width: 1)
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select Wallet Type",
                          style: AppFonts.beVietnamSemiBold18
                              .copyWith(color: AppColors.greyDarkest),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: TransferType.values.length,
                      itemBuilder: (context, index) {
                        final type = TransferType.values[index];
                        final style = AppTransferStyle.styles[type]!;
                        final isSelected = currentType == type;

                        return InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            setState(() {
                              if(from == true) selectedFromWallet = type;
                              else selectedToWallet = type;
                            });
                            controller?.text = style.title ?? "";
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.blue.withOpacity(0.1)
                                  : AppColors.white,
                              border: const Border(
                                  bottom: BorderSide(
                                      color: AppColors.greyLight,
                                      width: 0.5
                                  )
                              ),
                            ),
                            child: Row(
                              children: [
                                Image(
                                  image: style.icon!,
                                  width: 32,
                                  height: 32,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    style.title ?? "",
                                    style: AppFonts.beVietnamRegular14.copyWith(
                                      color: AppColors.greyDarkest,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  const Icon(
                                    Icons.check_circle,
                                    color: AppColors.blue,
                                    size: 20,
                                  ),
                              ],
                            ),
                          ),
                        );
                      }
                  ),
                  const SizedBox(height: 16),
                ],
              )
          );
        }
    );
  }

  void getMaxAmount(){
    String amountS = availableFrom!;
    String get = amountS.substring(0, amountS.length - 4);
    setState(() {
      amount!.text = get;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            height: 80,
            decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: AppColors.grey, width: 1
                  )
              ),
            ),
            padding: const EdgeInsets.fromLTRB(24,16,24,16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Transfer",
                  style: AppFonts.beVietnamSemiBold18.
                  copyWith(color: AppColors.greyDarkest),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Move money between wallets",
                  style: AppFonts.beVietnamLight14.
                  copyWith(color: AppColors.greyDark),
                  textAlign: TextAlign.left,
                )
              ],
            ),
          ),
          Container(
            color: AppColors.backgroundMain,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 28,),
                Text(
                  "Transfer move money between your wallets. Your total balance stays the same",
                  style: AppFonts.beVietnamLight14.
                  copyWith(color: AppColors.blue),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ScrollBubble(
                      title: "See all transactions",
                      marginRight: false,
                      isActive: false,
                      rightIcon: const Icon(AppIcons.arrowForward,
                        color: AppColors.grey, size: 12,),
                      onTap: (){
                        //navigate to transfer history
                        context!.push(AppRoute.transfer_history.path); //stack vao route
                      },
                    ),
                  ),
                ),

                //Main container
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.greyLight, width: 1),
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //From
                      Text(
                        "From wallet",
                        style: AppFonts.beVietnamRegular12.
                        copyWith(color: AppColors.greyDarkest),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 4,),
                      CustomTextField(
                        onTap: (){
                          showPopupMenu(
                            context,
                            fromWallet,
                            selectedFromWallet,
                            true
                          );
                        },
                        controller: fromWallet,
                        readOnly: true,
                        labelStyle: AppFonts.beVietnamRegular12.
                        copyWith(color: AppColors.greyDarkest),
                        prefixIcon: selectedFromWallet!= null
                          ? Image(image: AppTransferStyle.styles[selectedFromWallet]!.icon!,
                            width: 16, height: 16,) : null,
                      ),
                      const SizedBox(height: 4,),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Available:  ",
                              style: AppFonts.beVietnamRegular12.
                                copyWith(color: AppColors.grey),
                            ),
                            TextSpan(
                              text: availableFrom,
                              style: AppFonts.beVietnamRegular12.
                              copyWith(color: AppColors.greyDarkest),
                            )
                          ]
                        )
                      ),

                      InkWell(
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: (){
                          setState(() {
                            String mid = fromWallet!.text;
                            TransferType? midStyle = selectedFromWallet;
                            fromWallet!.text = toWallet!.text;
                            toWallet!.text = mid;
                            selectedFromWallet = selectedToWallet;
                            selectedToWallet = midStyle;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.mintVeryLight
                          ),
                          child: const Center(
                              child: Icon(
                                AppIcons.transferMoney,
                                size: 24,
                                color: AppColors.mint,
                              )
                          ),
                        ),
                      ),

                      //To
                      Text(
                        "To wallet",
                        style: AppFonts.beVietnamRegular12.
                        copyWith(color: AppColors.greyDarkest),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 4,),
                      CustomTextField(
                        onTap: (){
                          showPopupMenu(
                            context,
                            toWallet,
                            selectedToWallet,
                            false
                          );
                        },
                        controller: toWallet,
                        readOnly: true,
                        labelStyle: AppFonts.beVietnamRegular12.
                        copyWith(color: AppColors.greyDarkest),
                        prefixIcon: selectedToWallet!= null
                            ? Image(image: AppTransferStyle.styles[selectedToWallet]!.icon!,
                          width: 16, height: 16,) : null,
                      ),
                      const SizedBox(height: 4,),
                      Text.rich(
                          TextSpan(
                              children: [
                                TextSpan(
                                  text: "Available:  ",
                                  style: AppFonts.beVietnamRegular12.
                                  copyWith(color: AppColors.grey),
                                ),
                                TextSpan(
                                  text: availableTo,
                                  style: AppFonts.beVietnamRegular12.
                                  copyWith(color: AppColors.greyDarkest),
                                )
                              ]
                          )
                      ),

                      //Continue
                      const SizedBox(height: 20,),
                      Text(
                        "Amount",
                        style: AppFonts.beVietnamRegular12.
                        copyWith(color: AppColors.greyDarkest),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 4,),
                      CustomTextField(
                        controller: amount,
                        readOnly: false,
                        labelStyle: AppFonts.beVietnamRegular12.
                        copyWith(color: AppColors.greyDarkest),
                        prefixIcon: Container(
                          width: 32,
                          child: Center(
                            child: Text("VND",
                              style: AppFonts.beVietnamRegular14.
                              copyWith(color: AppColors.grey),
                            ),
                          ),
                        ),
                        suffixIcon: InkWell(
                          onTap: getMaxAmount,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            width: 48,
                            decoration: BoxDecoration(
                              color: AppColors.blueLight,
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Center(
                              child: Text("Max",
                                style: AppFonts.beVietnamRegular14.
                                  copyWith(color: AppColors.blue),
                              ),
                            ),
                          ),
                        ),
                      ),

                      //Date
                      const SizedBox(height: 20,),
                      Text(
                        "Date",
                        style: AppFonts.beVietnamRegular12.
                        copyWith(color: AppColors.greyDarkest),
                        textAlign: TextAlign.left,
                      ),
                      CustomTextField(
                        prefixIcon: const Icon(AppIcons.calender, size: 16,),
                        controller: date,
                        readOnly: true,
                        onTap: (){
                          _selectDate(context);
                        },
                        labelStyle: AppFonts.beVietnamRegular12.
                        copyWith(color: AppColors.greyDarkest),
                      ),

                      //Note
                      const SizedBox(height: 20,),
                      Text(
                        "Note (Optional)",
                        style: AppFonts.beVietnamRegular12.
                        copyWith(color: AppColors.greyDarkest),
                        textAlign: TextAlign.left,
                      ),
                      CustomTextField(
                        prefixIcon: const Icon(AppIcons.note, size: 16,),
                        controller: note,
                        hintText: "Add a note",
                        hintStyle: AppFonts.beVietnamRegular12.
                        copyWith(color: AppColors.grey),
                        labelStyle: AppFonts.beVietnamRegular12.
                        copyWith(color: AppColors.greyDarkest),
                        maxLines: 7,
                      ),

                      //Confirm button
                      confirmButton(),

                    ],
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}