import 'package:flutter/material.dart';
import 'package:my_project/core/ui/decorated_text_component.dart';
import 'package:my_project/core/ui/labeled_text_form_component.dart';
import 'package:my_project/core/ui/user_header_component.dart';
import 'package:my_project/helper/ui/ui_library.dart';

class UserSafeExposure extends StatelessWidget {
  const UserSafeExposure({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: UserHeaderComponent(showProfile: false),
              ),
              SizedBox(height: 20),
              LabeledTextFormComponent(label: 'Age', hint: '7'),
              SizedBox(height: 8),
              LabeledTextFormComponent(label: 'Fototype', hint: 'I'),
              SizedBox(height: 90),
              DecoratedTextComponent(text: 'CALCULATE EXPOSURE'),
              SizedBox(height: 160),
              Text('Exposición máxima de 20 minutos', textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}