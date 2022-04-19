import 'package:flutter/material.dart';
import 'package:my_project/data/viewmodels/fototipo_option.dart';

class FototipoOptionComponent extends StatelessWidget {
  final FototipoOptionViewmodel? model;
  FototipoOptionComponent({
    Key? key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/${model!.name}.png"),
                fit: BoxFit.cover),
            // color: model.color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 4),
        Text(model?.name ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
