import 'package:flutter/material.dart';
import 'package:my_project/core/bloc/childBloc.dart';
import 'package:my_project/core/bloc/locationBloc.dart';

class NoChildrenComponent extends StatefulWidget {
  final String appName;
  const NoChildrenComponent({Key? key, this.appName = ''}) : super(key: key);

  @override
  State<NoChildrenComponent> createState() => _NoChildrenComponentState();
}

class _NoChildrenComponentState extends State<NoChildrenComponent> {
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
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bienvenido a ${widget.appName}\n',
              textAlign: TextAlign.center,
            ),
            StreamBuilder(
                stream: childBloc.childrenStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var children = snapshot.data as List;
                    if (children.length == 0)
                      return Text(
                        'Parece que usted no tiene ningun hijo registrado',
                        textAlign: TextAlign.center,
                      );
                    else {
                      return Text("");
                    }
                  } else {
                    return Text("");
                  }
                }),
            const SizedBox(height: 10),
            Text(
              'Para registrar un hijo presiona el botón agregar',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
