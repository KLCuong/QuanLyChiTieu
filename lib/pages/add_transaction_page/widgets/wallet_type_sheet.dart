import 'package:flutter/material.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_enums.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';

class WalletTypeSelectorSheet extends StatelessWidget {
  final TransferType? currentType;
  final Function(TransferType selectedType) onSelected;

  const WalletTypeSelectorSheet({
    super.key,
    this.currentType,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
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
          // Header của Bottom Sheet
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.greyLight, width: 1),
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
                  onSelected(type);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.blue.withOpacity(0.1)
                        : AppColors.white,
                    border: const Border(
                      bottom: BorderSide(
                        color: AppColors.greyLight,
                        width: 0.5,
                      ),
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
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}