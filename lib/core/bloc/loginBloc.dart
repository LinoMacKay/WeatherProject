import 'package:my_project/core/bloc/validators.dart';
import 'package:my_project/core/provider/userProvider.dart';
import 'package:my_project/model/LoginDto.dart';
import 'package:my_project/router/routes.dart';
import 'package:my_project/utils/Utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginBloc with Validators {
  final userProvider = UserProvider();

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

  Future<bool> login(LoginDto loginDto) async {
    try {
      return await userProvider.login(loginDto);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> validateToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('userName') != null &&
        prefs.getString('userId') != null) {
      Utils.mainNavigator.currentState!.pushNamed(routeHome).then((value) {});
    }
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
