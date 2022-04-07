import 'package:flutter/material.dart';
import 'package:my_project/helper/ui/ui_library.dart';
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
                  child: Text('LOGIN'),
                ),
                const SizedBox(height: 20),
                AppTextForm(
                  width: 300,
                  controller: usernameController,
                  focusNode: userNameFocusNode,
                  style: style,
                  preffix: Icons.person,
                ),
                const SizedBox(height: 20),
                AppTextForm(
                  width: 300,
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  style: style,
                  preffix: Icons.vpn_key,
                ),
                const SizedBox(height: 80),
                AppButton(
                  text: 'Login',
                  onPressed: () {
                    Utils.mainNavigator.currentState!.pushNamed(routeHome);
                  },
                ),
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
