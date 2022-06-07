// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../model/ChildDto.dart';
import '../views/auth/create_account/create_account_view.dart' as _i2;
import '../views/auth/login/login_view.dart' as _i1;
import '../views/auth/recover_password/recover_password_view.dart' as _i6;
import '../views/children/create/children_create_view.dart' as _i3;
import '../views/children/update/children_update_view.dart' as _i4;
import '../views/user/location/user_location_view.dart' as _i5;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.LoginView());
    },
    CreateAccountRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.CreateAccountView());
    },
    ChildrenCreateRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.ChildrenCreateView());
    },
    /*ChildrenUpdateRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.ChildrenUpdateView());
    },*/
    UserLocationRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.UserLocationView());
    },
    RecoverPasswordRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.RecoverPasswordView());
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(LoginRoute.name, path: '/login'),
        _i7.RouteConfig(CreateAccountRoute.name, path: '/create-account-view'),
        _i7.RouteConfig(ChildrenCreateRoute.name,
            path: '/children-create-view'),
        /*_i7.RouteConfig(ChildrenUpdateRoute.name,
            path: '/children-update-view'),*/
        _i7.RouteConfig(UserLocationRoute.name, path: '/user-location-view'),
        _i7.RouteConfig(RecoverPasswordRoute.name, path: '/recover-password')
      ];
}

/// generated route for
/// [_i1.LoginView]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/login-view');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i2.CreateAccountView]
class CreateAccountRoute extends _i7.PageRouteInfo<void> {
  const CreateAccountRoute()
      : super(CreateAccountRoute.name, path: '/create-account-view');

  static const String name = 'CreateAccountRoute';
}

/// generated route for
/// [_i3.ChildrenCreateView]
class ChildrenCreateRoute extends _i7.PageRouteInfo<void> {
  const ChildrenCreateRoute()
      : super(ChildrenCreateRoute.name, path: '/children-create-view');

  static const String name = 'ChildrenCreateRoute';
}

/// generated route for
/// [_i4.ChildrenUpdateView]
class ChildrenUpdateRoute extends _i7.PageRouteInfo<void> {
  const ChildrenUpdateRoute()
      : super(ChildrenUpdateRoute.name, path: '/children-update-view');

  static const String name = 'ChildrenUpdateRoute';
}

/// generated route for
/// [_i5.UserLocationView]
class UserLocationRoute extends _i7.PageRouteInfo<void> {
  const UserLocationRoute()
      : super(UserLocationRoute.name, path: '/user-location-view');

  static const String name = 'UserLocationRoute';
}

/// generated route for
/// [_i6.RecoverPasswordView]
class RecoverPasswordRoute extends _i7.PageRouteInfo<void> {
  const RecoverPasswordRoute() : super(RecoverPasswordRoute.name, path: '/');

  static const String name = 'RecoverPasswordRoute';
}
