import 'package:flutter/material.dart';
import 'package:my_project/views/children/SingleChildCard.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
              "Hijos",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  SingleChildCard(),
                  SingleChildCard(),
                  SingleChildCard(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
