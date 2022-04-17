import 'package:flutter/material.dart';

class NoChildrenComponent extends StatelessWidget {
  final String appName;
  const NoChildrenComponent({Key? key, this.appName = ''}) : super(key: key);

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
              'Bienvenido a $appName\n',
              textAlign: TextAlign.center,
            ),
            Text(
              'Parece que usted no tiene ningun hijo registrado',
              textAlign: TextAlign.center,
            ),
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
