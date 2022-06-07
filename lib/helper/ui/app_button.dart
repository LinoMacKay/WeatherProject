part of 'ui_library.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final double width;
  final Color color;


  const AppButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.width = 200,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
        style: ElevatedButton.styleFrom(primary: color),
      ),
    );
  }
}
