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
  static List<AppRouteInfo> get all => [splash, home, transfer_history];
}