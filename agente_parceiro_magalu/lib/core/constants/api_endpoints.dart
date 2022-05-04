class Endpoints {
  //auth
  static const String login = '/login';
  static const String verifyCPF = '/user/sign-up-step1';
  static const String signUp = '/user/sign-up-step2';
  static const String sendCode = '/user/send-code';
  static const String confirmCodeChangePassword = '/user/change-password-step1';
  static const String changePassword = '/user/change-password-step2';

  //seller
  static const String getSellerListByAgentId = "/seller/get-sellers";
  static const String getSellerById = "/seller/get-seller";
  static const String getTags = "/seller/get-tags";
  static const String addTag = "/seller/add-tag";
  static const String addTagInSelelr = "/seller//add-tag-seller";

  static const String postSeller = "/seller/add-seller";
}
