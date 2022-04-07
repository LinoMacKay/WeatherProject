part of 'ui_library.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final String text;
  final Function()? onPressed;
  const AppIconButton({
    Key? key,
    required this.icon,
    this.iconSize = 24,
    this.text = '',
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: <Widget>[
          Icon(icon, size: iconSize),
          if (text.isNotEmpty)
            Text(
              text,
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
