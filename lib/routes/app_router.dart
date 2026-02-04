import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quanlychitieu/pages/home_page/home_page.dart';
import 'package:quanlychitieu/pages/login_page/login_page.dart';
import 'package:quanlychitieu/pages/set_new_password_page/email_otp_page.dart';
import 'package:quanlychitieu/pages/set_new_password_page/new_password_page.dart';
import 'package:quanlychitieu/pages/splash_page.dart';
import 'package:quanlychitieu/pages/transfer_history_page/transfer_history_page.dart';
import 'package:quanlychitieu/pages/first_update_profile_page/first_update_profile_page.dart';

import 'app_routes.dart';


final GoRouter goRouter = GoRouter(
  initialLocation: AppRoute.splash.path,
  routes: [
    GoRoute(
      path: AppRoute.splash.path,
      name: AppRoute.splash.name,
      pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SplashPage(),
          transitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: _slideTransition,
      )
    ),
    ShellRoute(
      builder: (context, state, child){
        return Scaffold(
          body: child,
        );
      },
      routes: [
        GoRoute(
          path: AppRoute.home.path,
          name: AppRoute.home.name,
          pageBuilder: (context, state){
            return CustomTransitionPage(
                key: state.pageKey,
                child: HomePage(),
                transitionDuration: const Duration(milliseconds: 400),
                transitionsBuilder: _slideTransition
            );
          }
        ),
        GoRoute(
          path: AppRoute.transfer_history.path,
          name: AppRoute.transfer_history.name,
          pageBuilder: (context, state){
            return CustomTransitionPage(
                key: state.pageKey,
                child: TransferHistoryPage(),
                transitionDuration: const Duration(milliseconds: 400),
                transitionsBuilder: _slideTransition
            );
          }
        ),
        GoRoute(
            path: AppRoute.login.path,
            name: AppRoute.login.name,
            pageBuilder: (context, state){
              return CustomTransitionPage(
                  key: state.pageKey,
                  child: LoginPage(),
                  transitionDuration: const Duration(milliseconds: 400),
                  transitionsBuilder: _slideTransition
              );
            }
        ),
        GoRoute(
            path: AppRoute.update_profile.path,
            name: AppRoute.update_profile.name,
            pageBuilder: (context, state){
              return CustomTransitionPage(
                  key: state.pageKey,
                  child: FirstUpdateProfilePage(),
                  transitionDuration: const Duration(milliseconds: 400),
                  transitionsBuilder: _slideTransition
              );
            }
        ),
        GoRoute(
            path: AppRoute.reset_pass.path,
            name: AppRoute.reset_pass.name,
            pageBuilder: (context, state){
              return CustomTransitionPage(
                  key: state.pageKey,
                  child: NewPasswordPage(),
                  transitionDuration: const Duration(milliseconds: 400),
                  transitionsBuilder: _slideTransition
              );
            }
        ),
        GoRoute(
            path: AppRoute.otp.path,
            name: AppRoute.otp.name,
            pageBuilder: (context, state){
              final email = state.extra as String? ?? '';
              return CustomTransitionPage(
                  key: state.pageKey,
                  child: EmailOtpPage(email: email,),
                  transitionDuration: const Duration(milliseconds: 400),
                  transitionsBuilder: _slideTransition
              );
            }
        ),
      ]
    )
  ]
);

Widget _slideTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child
){
  final curvedAnimation = CurvedAnimation(
    parent: animation,
    curve: Curves.easeInOut
  );
  return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 1.0),
        end: Offset.zero,
      ).animate(curvedAnimation),
      child: child,
  );

}
