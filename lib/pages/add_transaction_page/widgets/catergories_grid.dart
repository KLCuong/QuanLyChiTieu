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
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<CategoryType> filteredCategories = CategoryType.values.where((type) {
      if (widget.type == 0) {
        return type != CategoryType.income && type != CategoryType.transfer;
      } else {
        return type == CategoryType.income || type == CategoryType.transfer;
      }
    }).toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: filteredCategories.length,
      itemBuilder: (context, index) {
        final category = filteredCategories[index];
        final style = AppCategoryStyle.styles[category]!;
        final isSelected = (selectedIndex == index);

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            widget.onChanged?.call(category.name);
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? style.backgroundColor : AppColors.white,
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
                  Icon(
                    style.icon,
                    size: 28,
                    color: style.iconColor,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category.name,
                    style: AppFonts.beVietnamRegular8.copyWith(
                      color: AppColors.greyDarkest,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}