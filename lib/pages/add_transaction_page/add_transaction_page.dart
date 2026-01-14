import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quanlychitieu/pages/add_tranfer_page/add_transfer_page.dart';
import 'package:quanlychitieu/pages/add_transaction_page/widgets/catergories_grid.dart';
import 'package:quanlychitieu/pages/add_transaction_page/widgets/wallet_type_sheet.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_enums.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';
import 'package:quanlychitieu/utils/app_icons.dart';
import 'package:quanlychitieu/widgets/custom_text_field.dart';

class AddTransactionPage extends StatefulWidget{
  final VoidCallback? onBackToHome;

  const AddTransactionPage({
    super.key,
    this.onBackToHome
  });

  @override
  State createState() => _AddTransState();
}

class _AddTransState extends State<AddTransactionPage>{
  final List<String> typeTrans = ["Expense", "Income"];
  int selectedIndex = 0;
  bool? canSave = false;
  String? selectedTrans;
  FocusNode amountFocus = FocusNode();
  TransferType? transferType = TransferType.wallet;
  TextEditingController? amount = TextEditingController(text: "0");
  TextEditingController? date = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  TextEditingController? note = TextEditingController(text: "");
  TextEditingController? wallet = TextEditingController(
      text: AppTransferStyle.styles[TransferType.wallet]!.title,
  );

  void openFromWalletSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => WalletTypeSelectorSheet(
        currentType: transferType,
        onSelected: (type) {
          setState(() {
            transferType = type;
            wallet!.text = AppTransferStyle.styles[type]?.title ?? "";
          });
        },
      ),
    );
  }

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

  void checkCanSave(){
    if (amount!.text == "") amount!.text= "0";
    int? money = int.parse(amount!.text.toString());
    if(money != null && money > 0) {
      setState(() {
        canSave = true;
      });
    }
  }
  Widget confirmButton(bool? canSave){
    return InkWell(
      onTap: (){
        if(canSave == true){
        }else print("cant save");
      },
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            //border: Border.all(color: AppColors.mintDarkest, width: 1),
            borderRadius: BorderRadius.circular(16),
            color: (canSave == true)? AppColors.mintDark : AppColors.mintLight
        ),
        child: Center(
          child: Text(
            "Save", textAlign: TextAlign.center,
            style: AppFonts.beVietnamRegular16.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }

  Widget ChooseBuble(String? title, int type, {bool isActive = false}){
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: (isActive)? ((type == 0)? AppColors.orangeDark : AppColors.mintDark) : AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(title!, style: AppFonts.beVietnamRegular16.
          copyWith(color: (isActive)? AppColors.white: AppColors.greyDarkest),),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    amountFocus.addListener((){
      if (!amountFocus.hasFocus) {
        checkCanSave();
      }
    });
  }

  @override
  void dispose() {
    amountFocus.dispose();
    super.dispose();
  } //wallet type


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 60,
            color: AppColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Add Transaction", style: AppFonts.beVietnamSemiBold18.
                  copyWith(color: AppColors.greyDarkest), textAlign: TextAlign.start),
                GestureDetector(
                  onTap: widget.onBackToHome,
                  child: const Icon(AppIcons.close, size: 20,),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          typeTrans.length,
                              (index) => Flexible(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: ChooseBuble(
                                      typeTrans[index],
                                      index,
                                      isActive: (selectedIndex == index)
                                  ),
                                ),
                              )
                      ),
                    ),
                    const SizedBox(height: 32,),
                    //amount
                    Text(" Amount", style: AppFonts.beVietnamSemiBold14.
                    copyWith(color: AppColors.greyDarkest),),
                    CustomTextField(
                      keyboardType: TextInputType.number,
                      controller: amount,
                      onSubmitted: (_) => checkCanSave(),
                      focusNode: amountFocus,
                      suffixIcon: Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 32,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text("VND", style: AppFonts.beVietnamRegular14.
                          copyWith(color: AppColors.grey),),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24,),
                    //catergory
                    Text(" Catergory", style: AppFonts.beVietnamSemiBold14.
                    copyWith(color: AppColors.greyDarkest),),
                    const SizedBox(height: 8,),
                    CategoryGrid(
                      type : selectedIndex,
                      code: selectedTrans,
                      onChanged: (value){
                        setState(() {
                          selectedTrans = value;
                          print(selectedTrans);
                        });
                      },
                    ),
                    const SizedBox(height: 24,),
                    //Wallet
                    Text(" Wallet", style: AppFonts.beVietnamSemiBold14.
                    copyWith(color: AppColors.greyDarkest),),
                    const SizedBox(height: 8,),
                    CustomTextField(
                      onTap: () => openFromWalletSelector(),
                      controller: wallet,
                      readOnly: true,
                      labelStyle: AppFonts.beVietnamRegular12.
                      copyWith(color: AppColors.greyDarkest),
                      prefixIcon: transferType!= null
                          ? Image(image: AppTransferStyle.styles[transferType]!.icon!,
                        width: 16, height: 16,) : null,
                      suffixIcon: transferType!= null
                          ? const Icon(AppIcons.arrowDown, size: 16,) : null,
                    ),
                    //Date
                    const SizedBox(height: 20,),
                    Text(
                      "Date", style: AppFonts.beVietnamSemiBold14.
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
                      style: AppFonts.beVietnamSemiBold14.
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
                    const SizedBox(height: 16,),
                    Container(
                      margin: const EdgeInsets.fromLTRB(16, 0, 16 ,32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            child: InkWell(
                              onTap: (){
                                widget.onBackToHome?.call();
                              },
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(width: 1, color: AppColors.greyLight),
                                    color: AppColors.white
                                ),
                                child: Center(
                                  child: Text(
                                    "Cancel", textAlign: TextAlign.center,
                                    style: AppFonts.beVietnamRegular16.copyWith(color: AppColors.greyDarkest),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8,),
                          Flexible(
                            flex: 1,
                            child: confirmButton(canSave),
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
            )

          )
        ],
      ),

    );
  }
}