import 'package:flutter/material.dart';
import 'package:quanlychitieu/pages/home_page/widgets/custom_tab_bar.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_icons.dart';


class HomePage extends StatefulWidget{
  const HomePage({super.key});


  @override
  State createState() => _HomeState();
}

class _HomeState extends State<HomePage>{
  //for tabbar
  int _currentIndex = 0;
  final List<Widget> _pages = const[
    Center(child: Text('Home'),),
    Center(child: Text('Stats'),),
    Center(child: Text('Wallet'),),
    Center(child: Text('Profile'),),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      body: _pages[_currentIndex],
      floatingActionButton: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.readStatus.withOpacity(0.35), // tím mờ
                  blurRadius: 20,
                  spreadRadius: 6,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 56,
            height: 56,
            child: FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: AppColors.readStatus,
              elevation: 0,
              onPressed: () {},
              child: const Icon(
                AppIcons.add,
                color: AppColors.textWhite,
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