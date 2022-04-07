import 'package:flutter/material.dart';
import 'package:my_project/helper/constants/objects.dart';
import 'package:my_project/helper/ui/SeparatedWrap.dart';
import 'package:my_project/helper/ui/ui_library.dart';
import 'package:my_project/views/children/create/pages/page_three/components/fototipo_option_component.dart';

class ChildrenCreatePageThree extends StatelessWidget {
  final VoidCallback? onContinue, onBack;
  const ChildrenCreatePageThree({Key? key, this.onContinue, this.onBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          const Text('Registro de hijo (paso 3 de 4) - Escala Fitzpatrick'),
          const SizedBox(height: 20),
          const Text(
              'Seleccionar el tipo de fototipo de tu hijo según escala de Fitzpatrcik'),
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              '¿Qué es fototipo?',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SeparatedWrap(
            children: ConstantObjects.fototipos
                .map<Widget>(
                  (e) => FototipoOptionComponent(model: e),
                )
                .toList(),
          ),
          const SizedBox(height: 120),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              AppButton(onPressed: onBack, text: 'Cancelar', width: 100),
              AppButton(onPressed: onContinue, text: 'Continuar', width: 100),
            ],
          ),
        ],
      ),
    );
  }
}
