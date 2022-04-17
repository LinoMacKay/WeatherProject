import 'package:flutter/material.dart';
import 'package:my_project/core/bloc/childBloc.dart';
import 'package:my_project/views/children/SingleChildCard.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ChildBloc childBloc = ChildBloc();

  @override
  void initState() {
    childBloc.getChildren();
    super.initState();
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
              "Hijos",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder(
                stream: childBloc.childrenStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var children = snapshot.data as List;
                    return Expanded(
                      child: ListView.builder(
                          itemCount: children.length,
                          shrinkWrap: true,
                          itemBuilder: (ctx, indx) {
                            return SingleChildCard(children[indx]);
                          }),
                    );
                  } else {
                    return Container(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
