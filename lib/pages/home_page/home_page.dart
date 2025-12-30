import 'package:flutter/material.dart';
import 'package:quanlychitieu/pages/add_tranfer_page/add_trans_page.dart';
import 'package:quanlychitieu/pages/home_page/widgets/custom_tab_bar.dart';
import 'package:quanlychitieu/pages/main_page/main_page.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_icons.dart';
import 'package:quanlychitieu/widgets/page_style.dart';


class HomePage extends StatefulWidget{
  const HomePage({super.key});


  @override
  State createState() => _HomeState();
}

class _HomeState extends State<HomePage>{
  //for tabbar
  int _currentIndex = 0;
  final List<Widget> _pages = const[
    MainPage(),
    AddTranferPage(),
    Center(child: Text('Wallet'),),
    Center(child: Text('Profile'),),
    Center(child: Text('Stats'),),
  ];



  @override
  Widget build(BuildContext context) {
    return CustomPage(
      widget: _pages[_currentIndex],
      floatingActionButton: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            //margin: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.mintLight,
                  blurRadius: 8,
                  spreadRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 56,
            height: 56,
            child: FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: AppColors.mintDark,
              elevation: 0,
              onPressed: () {
                setState(() {
                  _currentIndex = 4;
                });
              },
              child: const Icon(
                AppIcons.add,
                color: AppColors.backgroundMain,
                size: 28,
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomTabBar(
        currentIndex: _currentIndex,
        onTabSelected: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}