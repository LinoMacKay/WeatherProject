// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:my_project/core/bloc/locationBloc.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../model/UviDto.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      //onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);
    tz.initializeTimeZones(); // <------

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('gsdfgsdfgsfdgsfd', 'dfajdsfijadsoijfaoijds');

  Future selectNotification(String? payload) async {
    //Handle notification tapped logic here
  }

  Future<void> scheduleNotifications() async {
    await flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        'repeating title',
        'repeating body',
        RepeatInterval.everyMinute,
        NotificationDetails(android: androidPlatformChannelSpecifics),
        androidAllowWhileIdle: true);
  }

  tz.TZDateTime _nextInstanceOf7AM() {
    var test = tz.getLocation('America/Bogota');
    final tz.TZDateTime now = tz.TZDateTime.now(test);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.getLocation('America/Bogota'), now.year, now.month, now.day, 7);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOf715AM() {
    var test = tz.getLocation('America/Bogota');
    final tz.TZDateTime now = tz.TZDateTime.now(test);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.getLocation('America/Bogota'), now.year, now.month, now.day, 7, 15);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> checkPendingNotificationRequests(context) async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content:
            Text('${pendingNotificationRequests.length} pending notification '
                'requests'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> scheduleNotificationsForUvi() async {
    Map<String, HourlyDto> horarios = {};
    List<num> diffdeHoras = [];
    var horario = LocationBloc().getFechaMasCercana(
        await LocationBloc().getUviInfoFromSP(), horarios, diffdeHoras);

    var toShow = await infoToShow(horarios);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        1231231245,
        'Ten Cuidado',
        'El UVI más alto de hoy será de ${toShow}',
        _nextInstanceOf7AM(),
        const NotificationDetails(
          android: AndroidNotificationDetails('daily notification channel id',
              'daily notification channel name',
              channelDescription: 'daily notification description'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
    var newInfo = await infoToShowUvConsider(horarios);
    if (newInfo.length > 0)
      await flutterLocalNotificationsPlugin.zonedSchedule(
          12312312,
          'Ten cuidado en este horario',
          newInfo,
          _nextInstanceOf715AM(),
          const NotificationDetails(
            android: AndroidNotificationDetails(
                'daily notification channel id2',
                'daily notification channel name2',
                channelDescription: 'daily notification description2'),
          ),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time);
  }

  Future<String> infoToShowUvConsider(horarios) async {
    var hoy = DateTime.now();
    var scheaduleForToday = DateTime(hoy.year, hoy.month, hoy.day, 7);
    var diaABuscar = LocationBloc().getUvEnDia(horarios);

    if (scheaduleForToday.isBefore(hoy)) {
      scheaduleForToday = scheaduleForToday.add(const Duration(days: 1));
      diaABuscar = LocationBloc().getUvEnDiaSiguiente(horarios);
    }

    return LocationBloc().uvAlto(diaABuscar);
  }

  Future<String> infoToShow(horarios) async {
    var hoy = DateTime.now();
    var scheaduleForToday = DateTime(hoy.year, hoy.month, hoy.day, 7);
    var diaABuscar = LocationBloc().getUvEnDia(horarios);

    if (scheaduleForToday.isBefore(hoy)) {
      scheaduleForToday = scheaduleForToday.add(const Duration(days: 1));
      diaABuscar = LocationBloc().getUvEnDiaSiguiente(horarios);
    }

    var mayor = 0.0;
    diaABuscar.forEach((element) {
      if (element[1] > mayor) mayor = element[1];
    });

    var mayorUvEnDia = diaABuscar.firstWhere((element) => element[1] == mayor);
    return DateFormat('hh:mm a', 'es_ES')
            .format(DateTime.tryParse(mayorUvEnDia[0])!) +
        " - " +
        DateFormat('hh:mm a', 'es_ES').format(
            DateTime.tryParse(mayorUvEnDia[0])!.add(Duration(hours: 1))) +
        " (${mayorUvEnDia[1].toString()})";
  }

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
}
