import 'package:flutter/material.dart';
import 'package:quanlychitieu/models/user_profile.dart';
import 'package:quanlychitieu/pages/add_tranfer_page/add_transfer_page.dart';
import 'package:quanlychitieu/pages/add_transaction_page/add_transaction_page.dart';
import 'package:quanlychitieu/pages/home_page/widgets/custom_tab_bar.dart';
import 'package:quanlychitieu/pages/main_page/main_page.dart';
import 'package:quanlychitieu/pages/profile_page/profile_page.dart';
import 'package:quanlychitieu/pages/wallet_page/wallet_page.dart';
import 'package:quanlychitieu/services/remote/auth%20service/auth_services.dart';
import 'package:quanlychitieu/services/remote/errors/supabase_error_handler.dart';
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
  final List<Widget> _pages = [];
  UserProfile? userProfile;
  final AuthService _authService = AuthService();
  bool loading = true;

  Future<void> getUserInfo() async{
    try{
      UserProfile? profile = await _authService.getUserProfile();
      if(profile != null){
        setState(() {
          userProfile = profile;
        });
      }
    }catch (e){
      final error = SupabaseErrorHandler.handle(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message.toString())),
      );
    }
  }

  void generatePage() async{
    await getUserInfo();
    if(userProfile != null){
      _pages.addAll([
        MainPage(
          userProfile: userProfile,
        ),
        AddTranferPage(
          userProfile: userProfile,
        ),
        WalletPage(
          userProfile: userProfile,
        ),
        ProfilePage(
          userProfile: userProfile,
        ),
        AddTransactionPage(
          userProfile: userProfile,
          onBackToHome: _goHome,
        )
      ]);
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    generatePage();
  }

  void _goHome(){
    setState(() {
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (loading == true)?
    const CustomPage(
      widget: Center(child: CircularProgressIndicator(),)
    ) : CustomPage(
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