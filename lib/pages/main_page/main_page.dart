import 'package:flutter/material.dart';
import 'package:quanlychitieu/models/transaction.dart';
import 'package:quanlychitieu/models/user_profile.dart';
import 'package:quanlychitieu/pages/main_page/widgets/money_card.dart';
import 'package:quanlychitieu/services/remote/transaction%20service/trans_services.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';
import 'package:quanlychitieu/utils/app_icons.dart';
import 'package:quanlychitieu/utils/app_enums.dart';
import 'package:quanlychitieu/widgets/custom_box_item.dart';
import 'package:quanlychitieu/widgets/scroll_buble.dart';
class MainPage extends StatefulWidget{
  final UserProfile? userProfile;

  const MainPage({
    this.userProfile,
    super.key,
  });

  @override
  State createState() => _MainState();
}

class _MainState extends State<MainPage>{
  int selectedIndex = 0;
  final List<String> categories = ["All", "Daily", "Weekly", "Monthly"];
  final TransactionService _transactionService = TransactionService();
  List<Transaction> _transactions = [];
  bool _isLoading = false;

  Widget UsernameTags(String? name){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Hello,", style: AppFonts.beVietnamLight40
                .copyWith(color: AppColors.greyDarkest, height: 1.0),
              textAlign: TextAlign.start,),
            Text((name)?? "User", style: AppFonts.beVietnamSemiBold40
                .copyWith(color: AppColors.greyDarkest, height: 1.0),
              textAlign: TextAlign.start, maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        InkWell(
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: (){},
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1.5, style: BorderStyle.solid,
                    color: AppColors.grey)
            ),
            child: const Icon(AppIcons.notificationsOutlined),
          ),
        ),
      ],
    );
  }

  Future<void> _loadTransactions() async {
    setState(() {
      _isLoading = true;
    });

    try {
      DateTime? fromDate;
      DateTime? toDate;
      final now = DateTime.now();

      switch (selectedIndex) {
        case 1: // Daily
          fromDate = DateTime(now.year, now.month, now.day);
          toDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
          break;
        case 2: // Weekly
          fromDate = now.subtract(Duration(days: now.weekday - 1));
          fromDate = DateTime(fromDate.year, fromDate.month, fromDate.day);
          toDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
          break;
        case 3: // Monthly
          fromDate = DateTime(now.year, now.month, 1);
          toDate = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
          break;
        default: // All
          fromDate = null;
          toDate = null;
      }

      final transactions = await _transactionService.getTransactionList(
        fromDate: fromDate,
        toDate: toDate,
      );

      setState(() {
        _transactions = transactions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading transactions: $e')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.userProfile!.fullName?? "User";

    return Container(
        padding: const EdgeInsets.fromLTRB(24,16,24,0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 24,),
            UsernameTags(name),
            Container(
              height: 72,
              margin: const EdgeInsets.only(top: 16, bottom: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: List.generate(
                    categories.length,
                        (index) => ScrollBubble(
                      title: categories[index],
                      isActive: selectedIndex == index,
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        _loadTransactions();
                      },
                    ),
                  ).toList(),
                ),
              ),
            ),
            IncomeSpentCard(transactions: _transactions),
            const SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent transaction',
                  style: AppFonts.beVietnamRegular14
                      .copyWith(color: AppColors.greyDarkest),
                  textAlign: TextAlign.start,
                ),
                // ScrollBubble(
                //   title: "See all",
                //   marginRight: false,
                //   isActive: false,
                //   rightIcon: const Icon(AppIcons.arrowForward,
                //     color: AppColors.grey,),
                //   onTap: (){},
                // )
              ],
            ),
            const SizedBox(height: 8,),
            Flexible(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _transactions.isEmpty
                    ? Center(
                  child: Text(
                    'No transactions found',
                    style: AppFonts.beVietnamRegular14
                        .copyWith(color: AppColors.greyDark),
                  ),
                )
                    : RefreshIndicator(
                  onRefresh: _loadTransactions,
                  child: ListView.builder(
                    itemCount: _transactions.length,
                    itemBuilder: (context, index){
                      final transaction = _transactions[index];

                      CategoryType categoryType;
                      try {
                        categoryType = CategoryType.values.firstWhere(
                              (e) => e.name.toLowerCase() == transaction.category.toLowerCase(),
                          orElse: () => CategoryType.values.first,
                        );
                      } catch (e) {
                        categoryType = CategoryType.values.first;
                      }

                      final style = AppCategoryStyle.styles[categoryType]!;
                      String amount = transaction.amount.toString();
                      final type = transaction.type;
                      if(type == "expense") {
                        amount = "\- ${amount}";
                      } else {
                        amount = "\+ ${amount}";
                      }
                      return CustomBoxItem(
                        title: transaction.category,
                        description: transaction.note ?? "No description",
                        total: amount.substring(0, amount.length - 2),
                        leftIcon: Icon(style.icon, color: style.iconColor,),
                        boxColor: style.backgroundColor,
                        date: transaction.date,
                      );
                    },
                  ),
                )
            )
          ],
        )
    );
  }
}