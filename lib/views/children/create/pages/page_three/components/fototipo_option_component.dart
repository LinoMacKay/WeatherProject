import 'package:flutter/material.dart';
import 'package:my_project/data/viewmodels/fototipo_option.dart';

class FototipoOptionComponent extends StatelessWidget {
  final FototipoOptionViewmodel? model;
  const FototipoOptionComponent({
    Key? key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 80,
            width: 80,
            decoration: const BoxDecoration(
              color: Colors.red,
              // color: model.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            model?.name ?? '',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
