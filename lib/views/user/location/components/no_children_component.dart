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
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bienvenido a $appName\nal parecer aún no tienes registrado a un hijo en la aplicación',
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
