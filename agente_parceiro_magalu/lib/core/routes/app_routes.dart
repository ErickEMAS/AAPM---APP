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
  static const checklistVisitaSeller = sellers + "/checklistVisitaSeller";
  static const checklistHistorico = sellers + "/historicoVisita";
  static const checklistOverview =
      sellers + checklistHistorico + "checklistOverview";
  static const calendar = '/calendar';

  static const agent = '/agent';
  static const userAgenteOverview = agent + '/userAgenteOverview';

  static const userAccount = '/userAccount';
  static const userDetail = userAccount + '/userDetail';
  static const confirmEmail = userAccount + '/confirmEmail';
  static const changeEmail = userAccount + '/changeEmail';
  static const changepassword = userAccount + '/changepassword';
  static const myTags = userAccount + '/myTags';
  static const faq = userAccount + '/faq';
  static const carteitaWithoutOwner = userAccount + '/carteitaWithoutOwner';
  static const agentListForCarteira = userAccount + '/agentListForCarteira';
  static const hunting = userAccount + '/hunting';
  static const huntingOverview = hunting + '/huntingOverview';

  static const adminAccount = '/adminAccount';
  static const addagente = adminAccount + '/addagente';
  static const addAdmin = adminAccount + '/addAdmin';
  static const sellerFields = adminAccount + '/sellerFields';
  static const questionsChecklist = adminAccount + '/questionsChecklist';
}
