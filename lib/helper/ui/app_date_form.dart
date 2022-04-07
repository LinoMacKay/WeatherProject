part of 'ui_library.dart';

class AppDateForm extends StatelessWidget {
  final DateTime controller;
  final TextStyle style;
  final Color iconColor;
  final IconData? suffix, preffix;
  final double minWidth;
  final double? width;
  final String label;
  const AppDateForm({
    Key? key,
    required this.controller,
    required this.style,
    this.iconColor = Colors.black,
    this.suffix,
    this.preffix,
    this.minWidth = 200,
    this.width,
    this.label = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: minWidth),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (preffix != null)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(preffix, size: 30, color: iconColor),
                ),
              Expanded(
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      if (label.isNotEmpty) Text(label),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(DateFormat('yyyy/MM/dd').format(controller)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (suffix != null)
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(suffix, size: 30, color: iconColor),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
