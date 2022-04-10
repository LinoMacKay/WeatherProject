import 'package:flutter/material.dart';
import 'package:my_project/core/ui/decorated_text_component.dart';
import 'package:my_project/core/ui/user_header_component.dart';
import 'package:my_project/helper/ui/ui_library.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 30),
                child: UserHeaderComponent(
                  showSignOff: false,
                  showProfile: false,
                  showDeleteProfile: true,
                  showEditProfile: true,
                  showEnterCommunity: true,
                ),
              ),
              const SizedBox(height: 60),
              DecoratedTextComponent(text: 'User 01', width: 150),
              const SizedBox(height: 20),
              DecoratedTextComponent(text: 'user01@gmail.com', width: 150),
              const SizedBox(height: 20),
              DecoratedTextComponent(text: '****************', width: 150),
            ],
          ),
        ),
      ),
    );
  }
}
