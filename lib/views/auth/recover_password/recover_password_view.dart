import 'package:flutter/material.dart';
import 'package:my_project/core/bloc/recoverPwdBloc.dart';
import 'package:my_project/helper/ui/ui_library.dart';
import 'package:my_project/router/routes.dart';
import 'package:my_project/utils/Utils.dart';

class RecoverPasswordView extends StatefulWidget {
  const RecoverPasswordView({Key? key}) : super(key: key);

  @override
  _RecoverPasswordView createState() => _RecoverPasswordView();
}

class _RecoverPasswordView extends State<RecoverPasswordView> {
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();

  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  final TextStyle style = const TextStyle();

  RecoverPwdBloc recoverPwdBloc = RecoverPwdBloc();
  bool errorEmail = false;


  confirmationDialog(String message){
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text(message),
        content: Text("Revise su correo para cambiar la contraseña con el link enviado"),
        actions: [
          TextButton(
              onPressed: (){
                Utils.mainNavigator.currentState!
                    .pushNamed(routeLoginView);
              },
              child: Text("Ok")),
        ],
      );
    },);
  }

  errorDialog(String message){
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text(message),
        content: Text("Ingrese un correo con cuenta registrada"),
        actions: [
          TextButton(
              onPressed: (){
                Utils.mainNavigator.currentState!
                    .pop();
              },
              child: Text("Ok")),
        ],
      );
    },);
  }

  errorSeverDialog(){
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Error!!"),
        content: Text("Ocurrio un error en el servidor, intentelo de nuevo"),
        actions: [
          TextButton(
              onPressed: (){
                Utils.mainNavigator.currentState!
                    .pop();
              },
              child: Text("Ok")),
        ],
      );
    },);
  }

  void recoveryPasswordButton( email)  {
    recoverPwdBloc.recoverPassword(email).then((response) {
      //print(response);
      if(response == 'Se mandó el mensaje con éxito') {
        confirmationDialog(response);
      }
      else if(response == Future.error("Internal Server Error")) {
        errorSeverDialog();
      }
      else {
        errorDialog(response);
      }
      }

    );

/*
    var response = recoverPwdBloc.recoverPassword(email);

    if(response == 'Se mandó el mensaje con éxito') {
      confirmationDialog(response);
    }else if(response == Future.error("Internal Server Error")) {
      errorSeverDialog();
    }
    else {
      errorDialog(response);
    }*/
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
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          // todo el contenido de la pagina
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                Text('Recuperar contraseña',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold, fontSize: 30),),
                                const SizedBox(height: 20),
                                Text("Ingresa el email registrado de la cuenta")
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          StreamBuilder(
                              stream: recoverPwdBloc.emailStream,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  onChanged: (val) => recoverPwdBloc.changeEmail(val),
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color),
                                  textInputAction: TextInputAction.next,
                                  onSaved: (value) {

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
                            stream: recoverPwdBloc.emailStream,
                              builder: (context, snapshot) {

                              recoverPwdBloc.emailStream.listen((event) {
                                  errorEmail = false;
                                }).onError((a) {
                                  errorEmail = true;
                                });
                                var validator = errorEmail;


                                return SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Color.fromRGBO(38, 95, 90, 1)),
                                      onPressed: !validator
                                          ? () {
                                        if (!validator) {
                                          //_saveForm();
                                          //print(recoverPwdBloc.email);
                                          recoveryPasswordButton(recoverPwdBloc.email);
                                        }
                                      }
                                          : null,
                                      child: Text(
                                        "Enviar",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300),
                                      )),
                                );
                              }),
                          const SizedBox(height: 20),
                          const SizedBox(height: 60),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('No eres miembro?'),
                              GestureDetector(
                                onTap: () {
                                  Utils.mainNavigator.currentState!
                                      .pushReplacementNamed(routeCreateAccountView);
                                },
                                child: Text(
                                  'Regístrate ahora',
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

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
