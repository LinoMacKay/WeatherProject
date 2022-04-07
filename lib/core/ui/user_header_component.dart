import 'package:flutter/material.dart';
import 'package:my_project/core/ui/decorated_text_component.dart';

class UserHeaderComponent extends StatelessWidget {
  final bool showProfile;
  const UserHeaderComponent({Key? key, this.showProfile = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 60,
          width: 60,
          child: Placeholder(),
        ),
        Text('USER 01'),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            DecoratedTextComponent(text: 'Sign Off'),
            if (showProfile)
              DecoratedTextComponent(text: 'My Profile'),
          ],
        ),
      ],
    );
  }
}