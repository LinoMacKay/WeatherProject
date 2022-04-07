import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChildrenCreatePageOneForm {
  final TextEditingController nameController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();

  final DateTime dateTimeController = DateTime.now();

  String get dateFormatted => DateFormat('dd de MMMM de yyyy', 'es_ES').format(dateTimeController);

  int get age {
    final now = DateTime.now();

    int years = now.year - dateTimeController.year;
    int months = now.month - dateTimeController.month;
    int days = now.day - dateTimeController.day;

    if (months < 0 || (months == 0 && days < 0)) {
      years--;
      months += (days < 0 ? 11 : 12);
    }

    if (days < 0) {
      final monthAgo = DateTime(now.year, now.month - 1, dateTimeController.day);
      days = now.difference(monthAgo).inDays + 1;
    }

    return years;
  }
}