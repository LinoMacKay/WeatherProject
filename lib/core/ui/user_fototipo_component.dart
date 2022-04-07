import 'package:flutter/material.dart';
import 'package:my_project/data/viewmodels/fototipo_option.dart';
import 'package:my_project/views/children/create/pages/page_three/components/fototipo_option_component.dart';

class UserFototipoComponent extends StatelessWidget {
  final FototipoOptionViewmodel? model;
  const UserFototipoComponent({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text('El fototipo de Karla según la escala de Fitzpatrick es logotipo II'),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            FototipoOptionComponent(model: model),
            const SizedBox(width: 60),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.edit,
                  size: 30,
                ),
                SizedBox(width: 50),
                Text('Cambiar fototipo'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}