import 'package:flutter/material.dart';
import 'package:my_project/core/ui/decorated_text_component.dart';
import 'package:my_project/core/ui/labeled_text_component.dart';
import 'package:my_project/core/ui/user_header_component.dart';
import 'package:my_project/helper/ui/ui_library.dart';

class UserUVSummary extends StatelessWidget {
  const UserUVSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: UserHeaderComponent(),
              ),
              Padding(
                padding: EdgeInsets.only(left: 90),
                child: Text('UV ACTUAL'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Placeholder(),
              ),
              LabeledTextComponent(
                  label: 'Highest uv of the day:', text: '11:00 PM - 12:18 PM'),
              LabeledTextComponent(
                  label: 'Range of hours with UVI considered high:',
                  text: '3:00 - 5:00'),
              LabeledTextComponent(label: 'Temperature:', text: '25°'),
              LabeledTextComponent(label: 'UV:', text: '9'),
              LabeledTextComponent(label: 'Hour:', text: '3:00 PM'),
              SizedBox(height: 250),
              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        DecoratedTextComponent(
                            text: 'the exposure time is safe!'),
                        SizedBox(width: 6),
                        Icon(Icons.notifications_none),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        DecoratedTextComponent(text: 'Highest uv of the day:'),
                        SizedBox(width: 6),
                        Icon(Icons.notifications_none),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
