import 'package:flutter/material.dart';
import 'package:my_project/helper/ui/ui_library.dart';

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
                  child: Text('CREATE FREE ACCOUNT'),
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
                  controller: emailController,
                  focusNode: emailFocusNode,
                  style: style,
                  preffix: Icons.email,
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
                  text: 'Register now',
                  onPressed: () {
                    print('login');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
