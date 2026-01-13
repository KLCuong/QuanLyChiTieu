import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quanlychitieu/pages/add_transaction_page/widgets/catergories_grid.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_enums.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';
import 'package:quanlychitieu/utils/app_icons.dart';
import 'package:quanlychitieu/widgets/custom_text_field.dart';

class AddTransactionPage extends StatefulWidget{

  const AddTransactionPage({
    super.key
  });

  @override
  State createState() => _AddTransState();
}

class _AddTransState extends State<AddTransactionPage>{
  final List<String> typeTrans = ["Expense", "Income"];
  int selectedIndex = 0;
  String? selectedTrans;
  TextEditingController? amount = TextEditingController(text: "0");
  TextEditingController? date = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  TextEditingController? note = TextEditingController(text: "");

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
                  onTap: (){},
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
                      controller: amount,
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
                    const SizedBox(height: 16,)
                  ],
                ),
            )

          )
        ],
      ),

    );
  }
}