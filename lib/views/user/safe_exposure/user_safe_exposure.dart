import 'package:flutter/material.dart';
import 'package:my_project/core/ui/user_header_component.dart';
import 'package:my_project/data/viewmodels/create_children_quote.dart';
import 'package:my_project/helper/ui/ui_library.dart';

class UserSafeExposure extends StatefulWidget {
  const UserSafeExposure({Key? key}) : super(key: key);

  @override
  State<UserSafeExposure> createState() => _UserSafeExposureState();
}

class _UserSafeExposureState extends State<UserSafeExposure> {
  final TextEditingController ageController = TextEditingController();
  final FocusNode ageFocusNode = FocusNode();
  final TextStyle style = const TextStyle();

  List<QuoteOption> quoteOptions = [
    QuoteOption(id: '1', description: 'I'),
    QuoteOption(id: '1', description: 'II'),
    QuoteOption(id: '1', description: 'III'),
    QuoteOption(id: '1', description: 'IV'),
    QuoteOption(id: '1', description: 'V'),
    QuoteOption(id: '1', description: 'VI'),
  ];
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 30),
                child: UserHeaderComponent(showProfile: false),
              ),
              const SizedBox(height: 40),
              const Text("Safe Exposure"),
              AppTextForm(
                isLeftLabel: true,
                label: 'Age',
                width: 300,
                controller: ageController,
                focusNode: ageFocusNode,
                style: style,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text("Tipo"),
                  ),
                  Container(
                    height: 40,
                    width: 200,
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.0, style: BorderStyle.solid),
                      ),
                    ),
                    alignment: Alignment.topCenter,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<QuoteOption>(
                        items: quoteOptions
                            .map((QuoteOption option) =>
                                DropdownMenuItem<QuoteOption>(
                                  child: Center(
                                    child: Text(
                                      option.description,
                                    ),
                                  ),
                                  value: option,
                                ))
                            .toList(),
                        iconSize: 20,
                        hint: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Seleccione su respuesta',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        value: null,
                        onChanged: (option) {},
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              AppButton(
                onPressed: () {},
                text: 'CALCULATE EXPOSURE',
                width: 200,
              ),
              const SizedBox(height: 160),
              const Text('Exposición máxima de 20 minutos',
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
