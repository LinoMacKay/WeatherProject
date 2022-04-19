import 'package:flutter/material.dart';
import 'package:my_project/data/viewmodels/fototipo_option.dart';
import 'package:my_project/views/children/create/pages/page_three/components/fototipo_option_component.dart';

class UserFototipoComponent extends StatelessWidget {
  final FototipoOptionViewmodel? model;
  String nombreHijo;
  UserFototipoComponent({required this.model, required this.nombreHijo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
            'El fototipo de ${nombreHijo} según la escala de Fitzpatrick es ${model!.name}'),
        const SizedBox(height: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FototipoOptionComponent(model: model),
            const SizedBox(width: 60),
            Text(' *El tono de piel mostrado es referencial'),
          ],
        ),
      ],
    );
  }
}
