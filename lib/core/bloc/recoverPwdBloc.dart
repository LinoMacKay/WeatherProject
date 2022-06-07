import 'package:my_project/core/bloc/validators.dart';
import 'package:my_project/core/provider/recoverPwdProvider.dart';
import 'package:rxdart/rxdart.dart';

class RecoverPwdBloc with Validators {

  RecoverPwdProvider recoverPwdProvider = RecoverPwdProvider();
  Future<dynamic> recoverPassword(dynamic email) async {
    var response = await recoverPwdProvider.recoverPassword(email);

    return response;
  }


  BehaviorSubject<String> _emailController = BehaviorSubject<String>();


  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);


  Function(String) get changeEmail => _emailController.sink.add;


  String get email => _emailController.value;

  dispose() {
    _emailController.close();
  }

}