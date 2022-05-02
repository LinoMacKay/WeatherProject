import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_project/core/bloc/provider.dart';
import 'package:my_project/router/app_router.gr.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_project/router/routes.dart';
import 'package:my_project/utils/NotificationHelper.dart';
import 'package:my_project/utils/Utils.dart';
import 'package:my_project/views/auth/create_account/create_account_view.dart';
import 'package:my_project/views/auth/login/login_view.dart';
import 'package:my_project/views/auth/recover_password/recover_password_view.dart';
import 'package:my_project/views/children/create/children_create_view.dart';
import 'package:my_project/views/children/update/children_update_view.dart';
import 'package:my_project/views/user/location/user_location_view.dart';

import '../model/ChildDto.dart';

class MainCommon extends StatelessWidget {
  final _appRouter = AppRouter();
  MainCommon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        scaffoldMessengerKey: NotificationUtil().scaffoldMessengerKey,
        title: 'Flutter Demo',
        //routerDelegate: _appRouter.delegate(),
        //routeInformationParser: _appRouter.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English, no country code
          Locale('es', ''), // Spanish, no country code
        ],
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Montserrat',
        ),
        navigatorKey: Utils.mainNavigator,
        onGenerateRoute: (settings) {
          Widget page;
          if (settings.name == routeLoginView) {
            page = const LoginView();
          } else if (settings.name == routeCreateAccountView) {
            page = const CreateAccountView();
          } else if (settings.name!.startsWith(routeChildrenCreateView)) {
            page = const ChildrenCreateView();
          } /*else if (settings.name!.startsWith(routeChildrenUpdateView)) {
            page = ChildrenUpdateView();
          } */
          else if (settings.name!.startsWith(routeHome)) {
            page = const UserLocationView();
          } else if (settings.name!.startsWith(routeRecoverPasswordView)) {
            page = const RecoverPasswordView();
          } else {
            throw Exception('Unknown route: ${settings.name}');
          }

          return MaterialPageRoute<dynamic>(
            builder: (context) {
              return page;
            },
            settings: settings,
          );
        },
        home: const LoginView(),
      ),
    );
  }
}
