import 'package:flutter/material.dart';
import 'package:my_project/core/bloc/registerBloc.dart';
import 'package:my_project/helper/ui/ui_library.dart';
import 'package:async/async.dart' show StreamGroup;
import 'package:my_project/utils/Utils.dart';

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

  RegisterBloc registerBloc = RegisterBloc();
  bool errorEmail = false;
  bool errorPassword = false;
  bool errorUser = false;
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
                        const SizedBox(height: 80),
                        StreamBuilder(
                            stream: StreamGroup.merge([
                              registerBloc.passwordStream,
                              registerBloc.emailStream,
                              registerBloc.userStream
                            ]),
                            builder: (context, snapshot) {
                              registerBloc.emailStream.listen((event) {
                                errorEmail = false;
                              }).onError((a) {
                                errorEmail = true;
                              });

                              registerBloc.userStream.listen((event) {
                                errorUser = false;
                              }).onError((a) {
                                errorUser = true;
                              });

                              registerBloc.passwordStream.listen((event) {
                                errorPassword = false;
                              }).onError((a) {
                                errorPassword = true;
                              });
                              var validator =
                                  errorEmail || errorPassword || errorUser;
                              print(validator);
                              return SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: !validator
                                            ? Color.fromRGBO(38, 95, 90, 1)
                                            : Colors.grey),
                                    onPressed: () {
                                      if (!validator) {
                                        //_saveForm();
                                        Utils.mainNavigator.currentState!.pop();
                                      }
                                    },
                                    child: Text(
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
