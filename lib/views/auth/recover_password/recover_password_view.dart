import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.grey.withOpacity(1)),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 90),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Recover password'),
                ),
                const SizedBox(height: 20),
                AppTextForm(
                  width: 300,
                  controller: emailController,
                  focusNode: emailFocusNode,
                  style: style,
                  preffix: Icons.vpn_key,
                ),
                const SizedBox(height: 20),
                AppTextForm(
                  width: 300,
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  style: style,
                  preffix: Icons.vpn_key,
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
                  text: 'Send',
                  onPressed: () {
                    print('recover password');
                  },
                ),
                const SizedBox(height: 20),
                AppButton(
                  text: 'ReSend',
                  onPressed: () {
                    print('recover password');
                  },
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Not a member?'),
                    GestureDetector(
                      onTap: () {
                        Utils.mainNavigator.currentState!
                            .pushReplacementNamed(routeCreateAccountView);
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
