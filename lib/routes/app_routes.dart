class AppRouteInfo{
  final String name;
  final String path;

  const AppRouteInfo({
    required this.name,
    required this.path
  });
}

class AppRoute{
  static const splash = AppRouteInfo(
    name: 'Splash_Page',
    path: '/splash'
  );
  static const home = AppRouteInfo(
    name: 'Home_Page',
    path: '/home'
  );
  static const transfer_history = AppRouteInfo(
    name: 'Transfer_History_Page',
    path: '/transfer_history'
  );
  static const login = AppRouteInfo(
    name: 'Login_Page',
    path: '/login'
  );
  static const update_profile = AppRouteInfo(
      name: 'Profile_Update_Page',
      path: '/profile_update_page'
  );
  static const reset_pass = AppRouteInfo(
      name: 'Reset_pass_page',
      path: '/reset_pass_page'
  );
  static const otp = AppRouteInfo(
    name: 'Email_Otp_Page',
    path: '/email_otp_page'
  );
  static List<AppRouteInfo> get all => [reset_pass, splash, otp,
    home, transfer_history, login, update_profile];
}