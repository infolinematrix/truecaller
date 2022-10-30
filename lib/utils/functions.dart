import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

dp(Object obj) {
  if (!kDebugMode) debugPrint(obj.toString());
}

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
  final now = DateTime.now().toLocal();
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
  DateTime now = DateTime.now().toLocal();
  int currentDay = now.weekday;
  DateTime firstDayOfWeek = now.subtract(Duration(days: currentDay - 1));
  return firstDayOfWeek;
}

DateTime lastDayOfWeek() {
  DateTime now = DateTime.now().toLocal();
  DateTime firstDayOfWeek =
      now.add(Duration(days: DateTime.daysPerWeek - now.weekday));
  return firstDayOfWeek;
}

DateTime firstDayOfMonth() {
  DateTime now = DateTime.now().toLocal();
  return DateTime(now.year, now.month, 1);
}

DateTime lastDayOfMonth() {
  DateTime now = DateTime.now().toLocal();
  return DateTime(now.year, now.month + 1, 0);
}

DateTime firstDayOfYear() {
  DateTime now = DateTime.now().toLocal();
  return DateTime(now.year, 1, 1);
}

DateTime lastDayOfYear() {
  DateTime now = DateTime.now().toLocal();
  return DateTime(now.year, 12, 31);
}

Future<void> gotoUrl({required String url, LaunchMode? launchMode}) async {
  final Uri uriUrl = Uri.parse(url.toString());

  if (!await launchUrl(uriUrl, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $uriUrl';
  }
}

Future<String> getIp() async {
  String strIp = '';
  List interfaces = await NetworkInterface.list();

  strIp = interfaces[0].addresses[0].address;

  return strIp.toString().trim();
}

Future<String> getFCMToken() async {
  final token =
      await FirebaseMessaging.instance.getToken().then((value) => value);
  return token!;
}

Future<void> subscribeFirebaseMessagingTopic({required String topic}) async {
  await FirebaseMessaging.instance.subscribeToTopic(topic.trim());
}
