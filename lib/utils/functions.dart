import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color randomOpaqueColor() {
  return Color(Random().nextInt(0xffff9999)).withAlpha(0xff);
}

int randomNumber({required int min, required int max}) {
  return min + Random().nextInt(max - min);
}

DateTime convertDateToLocal(String strDate) {
  var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(strDate, true);
  var dateLocal = dateTime.toLocal();

  return dateLocal;
}

DateTime dateTodayStart() {
  final now = DateTime.now().toUtc();
  final lastMidnight = now.subtract(Duration(
    hours: now.hour,
    minutes: now.minute,
    seconds: now.second,
    milliseconds: now.millisecond,
    microseconds: now.microsecond,
  ));

  return lastMidnight;
}

DateTime firstDayOfWeek() {
  DateTime now = DateTime.now().toUtc().toLocal();
  int currentDay = now.weekday;
  DateTime firstDayOfWeek = now.subtract(Duration(days: currentDay - 1));
  return firstDayOfWeek;
}

DateTime lastDayOfWeek() {
  DateTime now = DateTime.now().toUtc().toLocal();
  DateTime firstDayOfWeek =
      now.add(Duration(days: DateTime.daysPerWeek - now.weekday));
  return firstDayOfWeek;
}

DateTime firstDayOfMonth() {
  DateTime now = DateTime.now().toUtc();
  return DateTime(now.year, now.month, 1);
}

DateTime lastDayOfMonth() {
  DateTime now = DateTime.now().toUtc();
  return DateTime(now.year, now.month + 1, 0);
}

DateTime firstDayOfYear() {
  DateTime now = DateTime.now().toUtc();
  return DateTime(now.year, 1, 1);
}

DateTime lastDayOfYear() {
  DateTime now = DateTime.now().toUtc();
  return DateTime(now.year, 12, 31);
}
