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
  static const agent = '/agent';
  
  static const userAccount = '/userAccount';
  static const userDetail = userAccount + '/userDetail';
  static const confirmEmail = userAccount + '/confirmEmail';
  static const changeEmail = userAccount + '/changeEmail';
  static const changepassword = userAccount + '/changepassword';

  static const adminAccount = '/adminAccount';
  static const addagente = adminAccount + '/addagente';
  static const addAdmin = adminAccount + '/addAdmin';
  static const sellerFields = adminAccount + '/sellerFields';
  static const questionsChecklist = adminAccount + '/questionsChecklist';
}
