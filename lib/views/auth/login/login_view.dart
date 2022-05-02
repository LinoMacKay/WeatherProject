import 'package:flutter/material.dart';
import 'package:my_project/core/bloc/loginBloc.dart';
import 'package:my_project/helper/ui/ui_library.dart';
import 'package:my_project/model/LoginDto.dart';
import 'package:my_project/router/routes.dart';
import 'package:my_project/utils/NotificationHelper.dart';
import 'package:my_project/utils/Utils.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController usernameController = TextEditingController();
  final FocusNode userNameFocusNode = FocusNode();

  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  final TextStyle style = const TextStyle();
  LoginDto loginDto = LoginDto();
  LoginBloc loginBloc = LoginBloc();
  bool isLoading = false;
  Future<bool> _saveForm() async {
    setState(() {
      isLoading = true;
    });
    loginDto.password = loginBloc.password;
    loginDto.user = loginBloc.user;
    //agregando al data del bloc al dto
    var result = await loginBloc.login(loginDto);
    return result;
  }

  @override
  void initState() {
    loginBloc.validateToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: screenHeight,
          color: Color.fromRGBO(23, 114, 183, 1),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 90),
                  Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Inicio de Sesion',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                          ),
                          const SizedBox(height: 20),
                          StreamBuilder(
                              stream: loginBloc.userStream,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  //     key: Key(widget.user.lastName),
                                  onChanged: (val) => loginBloc.changeUser(val),
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color),
                                  //readOnly: !isEditable,
                                  textInputAction: TextInputAction.next,
                                  onSaved: (value) {
                                    // _updateDto.lastName = value;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Por favor ingrese su usuario";
                                    }
                                  },
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.person),
                                      errorText: snapshot.hasError
                                          ? snapshot.error.toString()
                                          : null,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black),
                                      ),
                                      labelText: 'Usuario',
                                      labelStyle: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color)),
                                );
                              }),
                          const SizedBox(height: 20),
                          StreamBuilder(
                              stream: loginBloc.passwordStream,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  obscureText: true,

                                  //     key: Key(widget.user.lastName),
                                  onChanged: (val) =>
                                      loginBloc.changePassword(val),
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color),
                                  //readOnly: !isEditable,
                                  textInputAction: TextInputAction.next,
                                  onSaved: (value) {
                                    // _updateDto.lastName = value;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Por favor ingrese su contraseña";
                                    }
                                  },
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.lock),
                                      errorText: snapshot.hasError
                                          ? snapshot.error.toString()
                                          : null,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black),
                                      ),
                                      labelText: 'Contraseña',
                                      labelStyle: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color)),
                                );
                              }),
                          const SizedBox(height: 30),
                          StreamBuilder(
                              stream: loginBloc.formValidStream,
                              builder: (context, snapshot) {
                                bool validator = false;
                                if (snapshot.hasData) {
                                  validator = snapshot.data as bool;
                                }
                                return SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: validator
                                              ? Color.fromRGBO(38, 95, 90, 1)
                                              : Colors.grey),
                                      onPressed: () async {
                                        if (validator) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          var result = await _saveForm();
                                          if (result) {
                                            NotificationUtil().showSnackbar(
                                                "Ha ingresado correctamente. Bienvenido",
                                                "success",
                                                null);
                                            await Future.delayed(
                                                Duration(milliseconds: 200));
                                            Utils.mainNavigator.currentState!
                                                .pushNamed(routeHome)
                                                .then((value) {});
                                          } else {
                                            NotificationUtil().showSnackbar(
                                                "Ha ocurrido un error, reintente nuevamente",
                                                "error",
                                                null);
                                          }
                                          setState(() {
                                            isLoading = false;
                                          });
                                        } else {
                                          NotificationUtil().showSnackbar(
                                              "Por favor rellene los campos de incio de sesión",
                                              "error",
                                              null);
                                        }
                                      },
                                      child: isLoading
                                          ? CircularProgressIndicator()
                                          : Text(
                                              "Ingresar",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w300),
                                            )),
                                );
                              }),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              Utils.mainNavigator.currentState!
                                  .pushNamed(routeRecoverPasswordView);
                            },
                            child: const Text(
                              '¿Olvidaste tu contraseña?',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text("O"),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(53, 150, 142, 1)),
                        onPressed: () {
                          Utils.mainNavigator.currentState!
                              .pushNamed(routeCreateAccountView);
                        },
                        child: Text(
                          "Registrar ahora",
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                  const SizedBox(height: 60),
                  /* Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Not a member?'),
                      GestureDetector(
                        onTap: () {
                          Utils.mainNavigator.currentState!
                              .pushNamed(routeCreateAccountView);
                        },
                        child: Text(
                          'Register now',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
