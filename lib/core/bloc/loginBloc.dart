import 'package:my_project/core/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class LoginBloc with Validators {
//  final userProvider = UserProvider();

  BehaviorSubject<String> _userController = BehaviorSubject<String>();

  BehaviorSubject<String> _passwordController = BehaviorSubject<String>();

  BehaviorSubject<String> _requestResult = BehaviorSubject<String>();
  bool flagControllersAreClosed = false;

  LoginBloc() {
    flagControllersAreClosed = false;
    init();
  }

  // Recuperar los datos del Stream
  Stream<String> get userStream =>
      _userController.stream.transform(validatePassword);

  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);

  Stream<String> get requestResultStream => _requestResult.stream;

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(userStream, passwordStream, (e, p) => true);

  // Insertar valores al Stream
  Function(String) get changeUser => _userController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeRequestResult => _requestResult.sink.add;

  // Obtener el último valor ingresado a los streams
  String get user => _userController.value;

  String get password => _passwordController.value;

  String get requestResult => _requestResult.value;

  dispose() {
    _userController.close();
    _passwordController.close();
    _requestResult.close();
    flagControllersAreClosed = true;
  }

  init() {
    if (_userController != null && !_userController.isClosed) {
      if (flagControllersAreClosed) {
        throw new Exception('Race condition at LoginBloc');
      }
      return;
    }
    flagControllersAreClosed = false;
    _userController = BehaviorSubject<String>();
    _passwordController = BehaviorSubject<String>();
    _requestResult = BehaviorSubject<String>();
  }

  /*Future<String> login(String email) async {
    try {
      return await userProvider.loginUser(email);
    } catch (e) {
      return Future.error(e);
    }
  }*/
}
