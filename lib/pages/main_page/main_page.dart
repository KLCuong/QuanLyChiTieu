import 'package:flutter/material.dart';
import 'package:quanlychitieu/pages/main_page/widgets/money_card.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';
import 'package:quanlychitieu/utils/app_icons.dart';
import 'package:quanlychitieu/widgets/scroll_buble.dart';
class MainPage extends StatefulWidget{

  const MainPage({
    super.key
  });

  @override
  State createState() => _MainState();
}

class _MainState extends State<MainPage>{
  int selectedIndex = 0;
  final List<String> categories = ["All", "Daily", "Weekly", "Monthly"];


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
              textAlign: TextAlign.start,),
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

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.fromLTRB(24,16,24,0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 24,),
          UsernameTags("David"),
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
                    },
                  ),
                ).toList(), // Thêm .toList() ở đây
              ),
            ),
          ),
          const IncomeSpentCard(),
        ],
      )
    );
  }
}