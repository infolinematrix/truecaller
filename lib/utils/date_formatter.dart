import 'package:intl/intl.dart' as intl;

//--
List<String> monthsShortUpercase = [
  'JAN',
  'FEB',
  'MAR',
  'APR',
  'MAY',
  'JUN',
  'JULY',
  'AUG',
  'SEPT',
  'OCT',
  'NOV',
  'DEC'
];

List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

Map<String, dynamic> dateMap(String dt) {
  DateTime parseDt = DateTime.parse(dt);

  final data = {
    'day': parseDt.day.toString(),
    'month': monthsShortUpercase[parseDt.month - 1],
    'year': parseDt.year.toString()
  };
  return data;
}

String formatDate(String dt) {
  if (dt == "null") return "Date Error";

  DateTime parseDt = DateTime.parse(dt);

  String dateSlug =
      "${parseDt.day.toString().padLeft(2, '0')}-${parseDt.month.toString().padLeft(2, '0')}-${parseDt.year.toString()}";

  return dateSlug;
}

String strToDate(String dt) {
  DateTime tempDate = DateTime.now();

  var suffix = "th";
  var digit = tempDate.day % 10;
  if ((digit > 0 && digit < 4) && (tempDate.day < 11 || tempDate.day > 13)) {
    suffix = ["st", "nd", "rd"][digit - 1];
  }

  String d =
      "${tempDate.day}$suffix ${months[tempDate.month - 1]}, ${tempDate.year}";

  return d;
}

String strToMonth(String dt) {
  DateTime tempDate = DateTime.now();

  String d = "${monthsShortUpercase[tempDate.month - 1]}, ${tempDate.year}";

  return d;
}

String strToMonthLong(String dt) {
  DateTime tempDate = DateTime.now();

  String d = "${months[tempDate.month - 1]}, ${tempDate.year}";

  return d;
}

String strToShortDate(String dt) {
  DateTime tempDate = DateTime.now();

  var suffix = "th";
  var digit = tempDate.day % 10;
  if ((digit > 0 && digit < 4) && (tempDate.day < 11 || tempDate.day > 13)) {
    suffix = ["st", "nd", "rd"][digit - 1];
  }
  String d =
      "${tempDate.day}$suffix-${monthsShortUpercase[tempDate.month - 1]}-${tempDate.year}";

  return d;
}

String strToShortMonth(int monthNo) {
  // DateTime tempDate = DateTime.now();

  String d = monthsShortUpercase[monthNo - 1];

  return d;
}

String strToDay(String dt) {
  DateTime tempDate = DateTime.now();

  String d = "${tempDate.day}";

  return d;
}

String strToYear(String dt) {
  DateTime tempDate = DateTime.now();

  String d = "${tempDate.year}";

  return d;
}

String strToWeekDay(DateTime dt) {
  // DateTime tempDate = DateTime.now();

  List<String> dayOfWeek = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesdday',
    'Thursday',
    'Friday',
    'Saturday'
  ];
  String d = dayOfWeek[dt.weekday];

  return d;
}

String timeAgoCustom(DateTime d) {
  // <-- Custom method Time Show  (Display Example  ==> 'Today 7:00 PM')     // WhatsApp Time Show Status Shimila
  Duration diff = DateTime.now().difference(d);
  if (diff.inDays > 365) {
    return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  }
  if (diff.inDays > 30) {
    return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  }
  if (diff.inDays > 7) {
    return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  }
  if (diff.inDays > 0) {
    return intl.DateFormat.E().add_jm().format(d);
  }
  if (diff.inHours > 0) {
    return "Today ${intl.DateFormat('jm').format(d)}";
  }
  if (diff.inMinutes > 0) {
    return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
  }
  return "just now";
}
