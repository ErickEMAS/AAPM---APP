class AppRoutes {
  static const dashboard = '/dashboard';

  //auth
  static const login = dashboard + '/login';
  static const signUp = dashboard + '/sign-up';
  static const forgotPassword = dashboard + '/forgot_password';

  static const home = '/home';

  static const sellers = '/sellers';
  static const sellerOverview = sellers + "/overview";
  static const editSeller = sellers + "/edit";

  static const calendar = '/calendar';
  static const userAccount = '/userAccount';
  static const adminAccount = '/adminAccount';
  static const agent = '/agent';
}
