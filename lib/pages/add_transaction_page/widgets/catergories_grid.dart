import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_enums.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';

class CategoryGrid extends StatefulWidget {
  final int type;
  final String? code;
  final void Function(String code)? onChanged;
  const CategoryGrid({
    super.key,
    this.type = 0,
    this.code,
    this.onChanged
  });

  @override
  State<CategoryGrid> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  int exp_selected = 0;
  int  inc_selected = 0;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: (widget.type == 0)? AppCategoryStyle.styles.length
          : AppTransferStyle.styles.length,
      itemBuilder: (context, index) {
        if(widget.type == 0){
          final type = CategoryType.values[index];
          CategoryStyle? item = AppCategoryStyle.styles[type];
          final isSelected = (exp_selected == index);
          return GestureDetector(
            onTap: () {
              setState(() {
                exp_selected = index;
              });
              widget.onChanged?.call(type.name.toString());
            },

            child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? item!.backgroundColor : AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.greyDarkest.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if(item!.icon != null) Icon(
                        item!.icon, size: 28,
                        color: item.iconColor,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        type.name,
                        style: AppFonts.beVietnamRegular8.copyWith(
                          color: AppColors.greyDarkest,
                        ),
                      ),
                    ],
                  ),
                )
            ),
          );
        }else{
          final type = TransferType.values[index];
          TransferStyle? item = AppTransferStyle.styles[type];
          final isSelected = (inc_selected == index);
          return GestureDetector(
            onTap: () {
              setState(() {
                inc_selected = index;
              });
              widget.onChanged?.call(type.name.toString());
            },

            child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? item!.bgcolor : AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.greyDarkest.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if(item!.icon != null) Image(
                        image: item.icon!,
                        height: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.title!,
                        style: AppFonts.beVietnamRegular8.copyWith(
                          color: AppColors.greyDarkest,
                        ),
                      ),
                    ],
                  ),
                )
            ),
          );
        }



      },
    );
  }
}
