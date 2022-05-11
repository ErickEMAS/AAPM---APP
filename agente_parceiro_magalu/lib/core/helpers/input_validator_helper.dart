class InputValidatorHelper {
  static String? validateCommonField(String? text) {
    if (text == "") return "Campo não pode ser vazio";

    return null;
  }

  static String? validateEmail(String? text) {
    if (text == "") return "Campo não pode ser vazio";
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(text!)) return 'E-mail não é valido';
    return null;
  }
}
