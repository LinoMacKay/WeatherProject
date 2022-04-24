import 'package:flutter/material.dart';
import 'package:my_project/core/bloc/childBloc.dart';
import 'package:my_project/core/bloc/locationBloc.dart';
import 'package:my_project/views/children/SingleChildCard.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ChildBloc childBloc = ChildBloc();
  LocationBloc locationBloc = LocationBloc();

  @override
  void initState() {
    locationBloc.getHomeData().then((value) {
      setState(() {
        childBloc.getChildren(value[1]);
      });
    });
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
                        child: children.length > 0
                            ? ListView.builder(
                                itemCount: children.length,
                                shrinkWrap: true,
                                itemBuilder: (ctx, indx) {
                                  return SingleChildCard(children[indx]);
                                })
                            : Center(
                                child: Text(
                                    "Usted no cuenta con ningun hijo registrado"),
                              ));
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
