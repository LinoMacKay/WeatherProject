import 'package:flutter/material.dart';
import 'package:my_project/core/ui/decorated_text_component.dart';

class UserHeaderComponent extends StatelessWidget {
  final bool showProfile;
  final bool showSignOff;
  final bool showEditProfile;
  final bool showDeleteProfile;
  final bool showEnterCommunity;
  const UserHeaderComponent(
      {Key? key,
      this.showProfile = true,
      this.showSignOff = true,
      this.showEditProfile = false,
      this.showDeleteProfile = false,
      this.showEnterCommunity = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 60,
              width: 60,
              child: CircleAvatar(),
            ),
            const Text('USER 01'),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (showSignOff) DecoratedTextComponent(text: 'Sign Off'),
                if (showProfile) DecoratedTextComponent(text: 'My Profile'),
                if (showEditProfile)
                  DecoratedTextComponent(text: 'Edite profile'),
                if (showDeleteProfile)
                  DecoratedTextComponent(text: 'Delete Profile'),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            if (showEnterCommunity)
              DecoratedTextComponent(text: 'Enter The Community'),
            const SizedBox(width: 20),
            if (showEnterCommunity) Icon(Icons.group)
          ],
        )
      ],
    );
  }
}
