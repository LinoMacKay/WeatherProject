import 'package:flutter/material.dart';

class FototipoOptionViewmodel {
  String? name;
  final int red, green, blue;
  final double opacity;
  String fototipo = "";

  FototipoOptionViewmodel(
      {this.name = '',
      this.red = 0,
      this.green = 0,
      this.blue = 0,
      this.opacity = .0,
      this.fototipo = ""});

  Color get color => Color.fromRGBO(red, green, blue, opacity);
}
