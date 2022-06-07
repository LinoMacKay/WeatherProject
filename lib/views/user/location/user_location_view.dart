import 'package:flutter/material.dart';
import 'package:my_project/helper/ui/ui_library.dart';
import 'package:my_project/router/routes.dart';
import 'package:my_project/utils/Utils.dart';
import 'package:my_project/views/Home.dart';
import 'package:my_project/views/children/create/children_create_view.dart';
import 'package:my_project/views/children/create/pages/page_two/childrenPhoto.dart';
import 'package:my_project/views/children/summary/children_summary_view.dart';
import 'package:my_project/views/tabs/ProfilePage.dart';
import 'package:my_project/views/tabs/SettingsPage.dart';
import 'package:my_project/views/user/location/components/no_children_component.dart';

import '../../children/update/children_update_view.dart';

class UserLocationView extends StatefulWidget {
  const UserLocationView({Key? key}) : super(key: key);

  @override
  _UserLocationViewState createState() => _UserLocationViewState();
}

class _UserLocationViewState extends State<UserLocationView> {
  final username = 'User 01';
  final greetings = 'buenas tardes';
  final appName = 'AppName';
  final children = <String>[];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        top: true,
        child: Navigator(
          key: Utils.homeNavigator,
          initialRoute: routeHome,
          onGenerateRoute: _onGenerateRoute,
        ),
      ),
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    Widget page = Home();
    switch (settings.name) {
      case routeHome:
        page = Home();
        break;
      case routeSettings:
        page = SettingsPage();
        break;
      case routeProfile:
        page = ProfilePage();
        break;
      case routeChildrenCreateView:
        page = ChildrenCreateView();
        break;
      case routeChildrenDetail:
        page = ChildrenSummaryView();
        break;
      case routeChildrenUpdateUpdate:
        page = ChildrenUpdateView();
        break;
      case routeChildrenPhoto:
        page = ChildrenPhoto();
        break;
      default:
        print("NOMBRE SUBRUTA: " + settings.name!);
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  }
}
