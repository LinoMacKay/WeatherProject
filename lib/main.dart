import 'package:flutter/material.dart';
import 'package:my_project/flavor/main_common.dart';
import 'package:my_project/utils/NotificationService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init(); // <----
  runApp(MainCommon());
}
