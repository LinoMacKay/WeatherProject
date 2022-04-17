import 'package:flutter/material.dart';
import 'package:my_project/core/provider/userProvider.dart';
import 'package:my_project/utils/Utils.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
