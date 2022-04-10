import 'dart:core';

class UserRegisterValidators {
  static const passwordRegex =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,32}$';
  static const emailRegex =
      r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&*+=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+';

  bool isValidUser(String userName) {
    //TODO
    // Validators - Format
    return userName.isNotEmpty;
  }

  bool isValidPassword(String password) {
    RegExp regExp = RegExp(passwordRegex);
    return regExp.hasMatch(password);
  }

  bool isValidEmail(String email) {
    RegExp regExp = RegExp(emailRegex);
    return regExp.hasMatch(email);
  }
}
