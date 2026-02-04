import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quanlychitieu/models/user_profile.dart';
import 'package:quanlychitieu/models/transaction.dart';
import 'package:quanlychitieu/services/remote/transaction%20service/trans_services.dart';
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
  final UserProfile? userProfile;
  const AddTransactionPage({
    super.key,
    this.onBackToHome,
    this.userProfile
  });

  @override
  State createState() => _AddTransState();
}

class _AddTransState extends State<AddTransactionPage>{
  final List<String> typeTrans = ["Expense", "Income"];
  int selectedIndex = 0;
  bool? canSave = false;
  bool _isSaving = false;
  String? selectedTrans;
  FocusNode amountFocus = FocusNode();
  TransferType? transferType = TransferType.wallet;
  TextEditingController? amount = TextEditingController(text: "0");
  TextEditingController? date = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  TextEditingController? note = TextEditingController(text: "");
  TextEditingController? wallet = TextEditingController(
    text: AppTransferStyle.styles[TransferType.wallet]!.title,
  );

  final TransactionService _transactionService = TransactionService();

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
      helpText: 'Select booking date',
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
    if(money != null && money > 0 && selectedTrans != null) {
      setState(() {
        canSave = true;
      });
    } else {
      setState(() {
        canSave = false;
      });
    }
  }

  Future<void> _saveTransaction() async {
    if (canSave != true || _isSaving) return;

    // Validate
    if (selectedTrans == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a category')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final amountValue = double.tryParse(amount!.text);
      if (amountValue == null || amountValue <= 0) {
        throw Exception('Invalid amount');
      }

      final dateFormat = DateFormat('dd/MM/yyyy');
      final parsedDate = dateFormat.parse(date!.text);
      final transType = selectedIndex == 0 ? 'expense' : 'income';
      final userId = widget.userProfile!.id;
      // Create transaction object
      final transaction = Transaction(
        id: '',
        userId: userId.toString(),
        type: transType,
        category: selectedTrans!,
        wallet: wallet!.text.toString().toLowerCase(),
        amount: amountValue,
        date: parsedDate,
        note: note!.text.isEmpty ? null : note!.text,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Save to database
      await _transactionService.createTransaction(transaction);

      setState(() {
        _isSaving = false;
      });

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Transaction saved successfully!'),
            backgroundColor: AppColors.mintDark,
          ),
        );

        // Go back to home
        widget.onBackToHome?.call();
      }
    } catch (e) {
      setState(() {
        _isSaving = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving transaction: $e'),
            backgroundColor: AppColors.orangeDark,
          ),
        );
      }
    }
  }

  Widget confirmButton(bool? canSave){
    return InkWell(
      onTap: _isSaving ? null : _saveTransaction,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: (canSave == true && !_isSaving)
                ? AppColors.mintDark
                : AppColors.mintLight
        ),
        child: Center(
          child: _isSaving
              ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
            ),
          )
              : Text(
            "Save",
            textAlign: TextAlign.center,
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
    amount?.dispose();
    date?.dispose();
    note?.dispose();
    wallet?.dispose();
    super.dispose();
  }


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
                                  selectedTrans = null; // Reset category when switching type
                                });
                                checkCanSave();
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
                          child: Text("\$", style: AppFonts.beVietnamRegular14.
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
                          print('Selected category: $selectedTrans');
                        });
                        checkCanSave();
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
                              onTap: _isSaving ? null : (){
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