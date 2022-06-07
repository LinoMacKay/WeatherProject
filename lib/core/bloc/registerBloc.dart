import 'package:my_project/core/bloc/validators.dart';
import 'package:my_project/model/RegisterDto.dart';
import 'package:rxdart/rxdart.dart';

import '../provider/userProvider.dart';

class RegisterBloc with Validators {
  final userProvider = UserProvider();
  BehaviorSubject<String> _userController = BehaviorSubject<String>();
  BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  BehaviorSubject<String> _passwordController = BehaviorSubject<String>();

  Stream<String> get userStream =>
      _userController.stream.transform(validatePassword);

  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);

  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);
    
  Stream<bool> get formValidStream =>
      Rx.combineLatest2(userStream, passwordStream, (e, p) => true);

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

    Future<bool> register(RegisterDto registerDto) async {
    try {
      return await userProvider.register(registerDto);
    } catch (e) {
      return Future.error(e);
    }
  }
}
