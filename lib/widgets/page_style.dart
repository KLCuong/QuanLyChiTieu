import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quanlychitieu/pages/add_tranfer_page/add_trans_page.dart';
import 'package:quanlychitieu/routes/app_routes.dart';
import 'package:quanlychitieu/utils/app_colors.dart';


class CustomPage extends StatefulWidget{
  final Widget? widget;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;

  const CustomPage({
    super.key,
    required this.widget,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar
  });

  @override
  State createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage>{

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isHome =
            GoRouterState.of(context).uri.path == AppRoute.home.path;

        if (isHome) {
          return await _showExitDialog(context);
        }

        if (GoRouter.of(context).canPop()) {
          context.pop();
          return false;
        }

        return await _showExitDialog(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundMain,
        floatingActionButton: widget.floatingActionButton,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        bottomNavigationBar: widget.bottomNavigationBar,
        body: widget.widget,
      ),
    );
  }


  Future<bool> _showExitDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Thoát ứng dụng?"),
        content: const Text("Bạn có chắc muốn quay lại không?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Không"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Có"),
          ),
        ],
      ),
    ) ?? false;
  }

}