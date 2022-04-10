import 'dart:core';

class RecoverPasswordValidators {
  static const emailRegex =
      r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&*+=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+';

  bool isValidEmail(String email) {
    RegExp regExp = RegExp(emailRegex);
    return regExp.hasMatch(email);
  }
}
