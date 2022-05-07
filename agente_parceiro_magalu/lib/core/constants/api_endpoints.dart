class Endpoints {
  //auth
  static const String login = '/login';
  static const String verifyCPF = '/user/sign-up-step1';
  static const String signUp = '/user/sign-up-step2';
  static const String sendCode = '/user/send-code';
  static const String confirmCodeChangePassword = '/user/change-password-step1';
  static const String changePassword = '/user/change-password-step2';
  static const String confirmEmail = '/user/confirm-email';
  static const String changeEmail = '/user/change-email';
  static const String signUpAgente = '/user/sign-up';
  static const String signUpAdmin = '/user/sign-up-admin';
  static const String deleteUser = '/user/delete-user'; //não integrada
  static const String getUsers = '/user/get-users'; //não integrada

  //seller

  static const String addField = '/seller/add-field'; //não integrada
  static const String addSeller = '/seller/add-seller'; //não integrada
  static const String updateSeller = '/seller/update-seller'; //não integrada
  static const String addQuestion = '/seller/add-question-checklist'; //não integrada
  static const String updateQuestion = '/seller/update-question-checklist'; //não integrada
  static const String answerChecklist = '/seller/answer-checklist'; //não integrada
  static const String updateTag = '/seller/update-tag'; //não integrada
  static const String deleteTag = '/seller/delete-tag'; //não integrada
  static const String addTagInSeller = '/seller/add-tag-seller'; //não integrada
  static const String tranferCarteira = '/seller/tranfer-carteira'; //não integrada
  static const String addFAQ = '/seller/add-faq'; //não integrada
  static const String updateFAQ = '/seller/update-faq'; //não integrada
  static const String addHunting = '/seller/add-hunting'; //não integrada
  static const String updateHunting = '/seller/update-hunting'; //não integrada
  static const String setVisitItinerary = '/seller/set-visit-itinerary'; //não integrada
  static const String visiting = '/seller/visiting'; //não integrada
  static const String resetVisitItinerary = '/seller/reset-visit-itinerary'; //não integrada
  static const String getSeller = '/seller/get-seller'; //não integrada
  static const String getSellers = '/seller/get-sellers'; //não integrada
  static const String getChecklists = '/seller/get-activity'; //não integrada
  static const String getFields = '/seller/get-fields'; //não integrada
  static const String getQuestions = '/seller/get-questions'; //não integrada
  static const String getCarteiraWithoutOwner = '/seller/get-carteira-without_owner'; //não integrada
  static const String getFAQs = '/seller/get-faqs'; //não integrada
  static const String getHuntings = '/seller/get-huntings'; //não integrada

  static const String getSellerListByAgentId = '/seller/get-sellers';
  static const String postSeller = '/seller/add-seller';
  static const String getSellerById = '/seller/get-seller';

  static const String getTags = '/seller/get-tags';
  static const String addTag = '/seller/add-tag';
  static const String addTagInSelelr = '/seller/add-tag-seller';

  static const String startChecklist = '/seller/start-checklist-by-selerid'; 
}
