import 'package:flutter/foundation.dart';

void log(tag) {
  _printLog(tag.toString());
}

void _printLog(String tag) {
  if (kDebugMode) {
    debugPrint(tag);
  }
}
