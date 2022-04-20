import 'package:flutter/material.dart';
import 'package:my_project/core/bloc/registerBloc.dart';
import 'package:my_project/helper/ui/ui_library.dart';
import 'package:async/async.dart' show StreamGroup;
import 'package:my_project/model/RegisterDto.dart';
import 'package:my_project/utils/NotificationHelper.dart';
import 'package:my_project/utils/Utils.dart';

import '../../../router/routes.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({Key? key}) : super(key: key);

  @override
  _CreateAccountViewState createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final TextEditingController usernameController = TextEditingController();
  final FocusNode userNameFocusNode = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();

  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  final TextStyle style = const TextStyle();

  RegisterDto registerDto = RegisterDto(); // SSS
  RegisterBloc registerBloc = RegisterBloc();
  bool errorEmail = false;
  bool errorPassword = false;
  bool errorUser = false;
  bool isLoading = false;

  Future<bool> _saveForm() async {
    registerDto.user = registerBloc.user;
    registerDto.email = registerBloc.email;
    registerDto.password = registerBloc.password;

    var result = await registerBloc.register(registerDto);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.grey.withOpacity(1)),
        body: Container(
          height: screenHeight,
          color: Color.fromRGBO(23, 114, 183, 1),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ),
                        const SizedBox(height: 20),
                        StreamBuilder(
                            stream: registerBloc.userStream,
                            builder: (context, snapshot) {
                              return TextFormField(
                                //     key: Key(widget.user.lastName),
                                onChanged: (val) =>
                                    registerBloc.changeUser(val),
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
                            stream: registerBloc.emailStream,
                            builder: (context, snapshot) {
                              return TextFormField(
                                //     key: Key(widget.user.lastName),
                                onChanged: (val) =>
                                    registerBloc.changeEmail(val),
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
                                    return "Por favor ingrese su correo";
                                  }
                                },
                                decoration: InputDecoration(
                                    icon: Icon(Icons.email),
                                    errorText: snapshot.hasError
                                        ? snapshot.error.toString()
                                        : null,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.black),
                                    ),
                                    labelText: 'Email',
                                    labelStyle: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color)),
                              );
                            }),
                        const SizedBox(height: 20),
                        StreamBuilder(
                            stream: registerBloc.passwordStream,
                            builder: (context, snapshot) {
                              return TextFormField(
                                obscureText: true,

                                //     key: Key(widget.user.lastName),
                                onChanged: (val) =>
                                    registerBloc.changePassword(val),
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
                                    icon: Icon(Icons.vpn_key),
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
                        const SizedBox(height: 25),
                        StreamBuilder(
                            stream: registerBloc.formValidStream,
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
                                        primary: Color.fromRGBO(38, 95, 90, 1)),
                                    onPressed: () async {
                                      if (validator) {
                                        var result = await _saveForm();
                                        if (result) {
                                          NotificationUtil().showSnackbar(
                                              context,
                                              "Su cuenta se ha registrado correctamente",
                                              "success",
                                              null);
                                          await Future.delayed(
                                              Duration(milliseconds: 400));
                                          Utils.mainNavigator.currentState!
                                              .pushNamed(routeLoginView)
                                              .then((value) {});
                                        } else {
                                          NotificationUtil().showSnackbar(
                                              context,
                                              "Ha ocurrido un error en el registro, reintente nuevamente",
                                              "error",
                                              null);
                                        }
                                        setState(() {
                                          isLoading = false;
                                        });
                                      } else {
                                        NotificationUtil().showSnackbar(
                                            context,
                                            "Por favor rellene los campos de registro",
                                            "error",
                                            null);
                                      }
                                    },
                                    child: isLoading
                                        ? CircularProgressIndicator()
                                        : Text(
                                            "Register",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w300),
                                          )),
                              );
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
