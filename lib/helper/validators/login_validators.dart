class LoginValidators {
  bool isValidLogin(String userName, String password) {
    return userName.isNotEmpty && password.isNotEmpty;
  }
}
