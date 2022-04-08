import 'package:flutter/material.dart';
import 'package:my_project/core/bloc/loginBloc.dart';

class Provider extends InheritedWidget {
  //singleton pattern
  static Provider? _instancia;
  factory Provider({Widget? child}) {
    _instancia ??= Provider._internal(child: child!);
    return _instancia!;
  }
  Provider._internal({Widget? child}) : super(child: child!);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  //blocs

  final loginBloc = LoginBloc();

  static LoginBloc loginBlocOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!.loginBloc;
  }
}
