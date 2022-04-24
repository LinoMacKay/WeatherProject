import 'package:flutter/material.dart';
import 'package:my_project/core/provider/userProvider.dart';
import 'package:my_project/utils/Utils.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Widget _section(String title, Function? onPressed) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Expanded(
        child: Material(
          shape: Border(bottom: BorderSide(width: 2, color: Colors.black)),
          child: TextButton(
            style: TextButton.styleFrom(primary: Colors.black),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
            onPressed: onPressed!(),
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        width: screenWidth,
        height: screenHeight,
        child: Column(
          children: [
            Text(
              "Configuración",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            _section("Configuración de cuenta", () {}),
            Expanded(child: SizedBox()),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: () {
                  UserProvider userProvider = UserProvider();
                  userProvider.logout().then((value) {
                    Utils.mainNavigator.currentState!.pop();
                  });
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                label: Text(
                  "Cerrar Sesión",
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
