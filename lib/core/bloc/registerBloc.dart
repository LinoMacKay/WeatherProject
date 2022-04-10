import 'package:my_project/core/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc with Validators {
  BehaviorSubject<String> _userController = BehaviorSubject<String>();
  BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  BehaviorSubject<String> _passwordController = BehaviorSubject<String>();

  Stream<String> get userStream =>
      _userController.stream.transform(validatePassword);

  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);

  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);

  Function(String) get changeUser => _userController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;

  String get user => _userController.value;
  String get password => _passwordController.value;
  String get email => _emailController.value;

  dispose() {
    _userController.close();
    _passwordController.close();
    _emailController.close();
  }
}
