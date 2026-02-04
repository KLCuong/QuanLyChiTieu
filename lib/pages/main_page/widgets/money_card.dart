import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:quanlychitieu/models/transaction.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';

class IncomeSpentCard extends StatelessWidget {
  final List<Transaction> transactions;
  const IncomeSpentCard({
    super.key,
    required this.transactions
  });

  @override
  Widget build(BuildContext context) {
    double totalIncome = 0;
    double totalExpense = 0;

    for (var transaction in transactions) {
      if (transaction.type == 'income') {
        totalIncome += transaction.amount;
      } else if (transaction.type == 'expense') {
        totalExpense += transaction.amount;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildItem(
                  color: AppColors.mint,
                  title: "Income",
                  value: "\$${totalIncome.toString()}",
                ),
                const SizedBox(height: 16),
                _buildItem(
                  color: AppColors.orange,
                  title: "Spent",
                  value: "\$${totalExpense.toString()}",
                ),
              ],
            ),
          ),

          SizedBox(
            height: 120,
            width: 120,
            child: PieChart(
              PieChartData(
                sectionsSpace: 4,
                centerSpaceRadius: 28,
                sections: [
                  PieChartSectionData(
                    value: totalIncome,
                    color: AppColors.mint,
                    radius: 24,
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: totalExpense,
                    color: AppColors.orange,
                    radius: 24,
                    showTitle: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required Color color,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 30,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppFonts.beVietnamRegular14.copyWith(
                color: AppColors.greyDark,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: AppFonts.beVietnamSemiBold18.copyWith(
                color: AppColors.greyDarkest,
              ),
            ),
          ],
        )
      ],
    );
  }
}
