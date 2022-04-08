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
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
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
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return Dialog(
                        insetPadding: EdgeInsets.all(10),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: screenWidth,
                          height: screenHeight * 0.3,
                          child: Column(
                            children: [
                              Text(
                                "¿Qué es el Fototipo?",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Text(
                '¿Qué es fototipo?',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
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
