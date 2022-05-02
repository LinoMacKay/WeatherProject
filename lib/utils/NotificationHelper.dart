import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationUtil {
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void showSnackbar(String message, String type, SnackBarAction? action) {
    Color background = Colors.white;
    if (type == "error") {
      background = Colors.red;
    }
    if (type == "success") {
      background = Colors.green.shade800;
    }

    if (type == "warning") {
      background = Colors.amber[700]!;
    }
    scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
      backgroundColor: background,
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      action: action,
      duration: Duration(milliseconds: 700),
    ));
    // ScaffoldMessenger.of(context).showSnackBar();
  }
}
