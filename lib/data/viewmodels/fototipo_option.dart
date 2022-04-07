import 'package:flutter/material.dart';

class FototipoOptionViewmodel {
  final String name;
  final int red, green, blue;
  final double opacity;

  FototipoOptionViewmodel({
    this.name = '',
    this.red = 0,
    this.green = 0,
    this.blue = 0,
    this.opacity = .0,
  });

  Color get color => Color.fromRGBO(red, green, blue, opacity);
}
