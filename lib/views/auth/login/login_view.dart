import 'package:flutter/material.dart';
import 'package:my_project/core/bloc/loginBloc.dart';
import 'package:my_project/helper/ui/ui_library.dart';
import 'package:my_project/model/LoginDto.dart';
import 'package:my_project/router/routes.dart';
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

  void _saveForm() {
    loginDto.password = loginBloc.password;
    loginDto.user = loginBloc.user;
    //agregando al data del bloc al dto
    print(loginDto);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 90),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Inicio de Sesion',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
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
                            errorText: snapshot.hasError
                                ? snapshot.error.toString()
                                : null,
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
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
                        onChanged: (val) => loginBloc.changePassword(val),
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
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
                            errorText: snapshot.hasError
                                ? snapshot.error.toString()
                                : null,
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                            labelText: 'Contraseña',
                            labelStyle: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color)),
                      );
                    }),
                const SizedBox(height: 80),
                StreamBuilder(
                    stream: loginBloc.formValidStream,
                    builder: (context, snapshot) {
                      bool validator = false;
                      if (snapshot.hasData) {
                        validator = snapshot.data as bool;
                      }
                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary:
                                  validator ? Colors.blueAccent : Colors.grey),
                          onPressed: () {
                            if (validator) {
                              _saveForm();
                              Utils.mainNavigator.currentState!
                                  .pushNamed(routeHome);
                            }
                          },
                          child: Text("Iniciar Sesión"));
                    }),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Utils.mainNavigator.currentState!
                        .pushNamed(routeRecoverPasswordView);
                  },
                  child: const Text(
                    'Forget Password',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                Row(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
