import 'package:jdate/jdate.dart';

void main() {
  // From DateTime
  print('\n---From DateTime---');
  print(DateTime.now().toJDate());
  print(DateTime(2020).toJDate());
  print(DateTime(2020, 7).toJDate());
  print(DateTime(2020, 7, 16).toJDate());
  print(DateTime(2020, 7, 16, 12).toJDate());
  print(DateTime(2020, 7, 16, 12, 18).toJDate());
  print(DateTime(2020, 7, 16, 12, 18, 30).toJDate());
  print(DateTime(2020, 7, 16, 12, 18, 30, 450).toJDate());

  // Jalali Date Constructor
  print('\n---Jalali Date Constructor---');
  print(JDate.now());
  print(JDate(1399));
  print(JDate(1399, 4));
  print(JDate(1399, 4, 15));
  print(JDate(1399, 4, 15, 20));
  print(JDate(1399, 4, 15, 20, 25));
  print(JDate(1399, 4, 15, 20, 25, 30));
  print(JDate(1399, 4, 15, 20, 25, 30, 650));

  // Other Constructors
  print('\n---Other Constructor---');
  print(JDate.fromDateTime(DateTime.now()));
  print(JDate.fromMillisecondsSinceEpoch(1595130701095));
  print(
      JDate.fromMicrosecondsSinceEpoch(DateTime.now().microsecondsSinceEpoch));
  print(JDate.utc(1377, 10, 11));

  // Change Date
  print('\n---Change Date---');
  print(JDate.now().changeTo(year: 1357, day: 10));
  print(JDate.now().changeTo(minute: 35, second: 10, millisecond: 250));
  var changeDate = JDate.now();
  print(changeDate);
  changeDate
    ..year = 1377
    ..minute = 10
    ..day = 2;
  print(changeDate);

  // JDate Parameters
  print('\n---JDate Parameters---');
  var dateParam = JDate.now();
  print('Year: ${dateParam.year} - '
      'Month: ${dateParam.month} - '
      'Day: ${dateParam.day} - '
      'Hour: ${dateParam.hour} - '
      'Minute: ${dateParam.minute} - '
      'Second: ${dateParam.second} - '
      'Millisecond: ${dateParam.millisecond} - '
      'Microsecond: ${dateParam.microsecond} - '
      'MillisecondsSinceEpoch: ${dateParam.millisecondsSinceEpoch} - '
      'MicrosecondsSinceEpoch: ${dateParam.microsecondsSinceEpoch} - '
      'TimeZoneName: ${dateParam.timeZoneName} - '
      'TimeZoneOffset: ${dateParam.timeZoneOffset} - '
      'IsUtc: ${dateParam.isUtc} - '
      'MonthLength: ${dateParam.monthLength} - '
      'IsLeapYear: ${dateParam.isLeapYear} - '
      'MonthName: ${dateParam.monthName} - '
      'ShortYear: ${dateParam.shortYear} - '
      'WeekdayName: ${dateParam.weekdayName} - '
      'Weekday: ${dateParam.weekday}');

  // custom format
  print('\n---Custom format---');
  print(JDate.now().toString());
  print(JDate.now().echo('l، d F V ساعت H:i:s'));
  print(JDate.now().echo('Y/m/d'));

  // useful static methods
  print('\n---Static methods---');
  print(JDate.gregorianToJalali(2020, 7, 16));
  print(JDate.jalaliToGregorian(1399, 4, 26));
  print(JDate.gregorianToHijri(2020, 7, 16));
  print(JDate.hijriToGregorian(1441, 11, 25));
  print(JDate.hijriToJalali(1441, 11, 25));
  print(JDate.jalaliToHijri(1399, 6, 6));

  // useful extension
  print('\n---Extension methods---');
  print('۱۲۳۴۵۶۷۸۹۰'.numbersToEnglish());
  print(JDate.now().toString().numbersToPersian());
  print(60000000.toPersianWords());
  print((-250).toPersianWords());
  print(550.toPersianWords(true));
  print(DateTime.now().add(Duration(days: 2)).toJDate());

  // parse
  print('\n---Parse---');
  print(DateTime.parse('2012-02-27 13:27:00').toJDate());
  print(DateTime.parse('2012/02/27 13:27:00'.replaceAll(RegExp(r'[/\\]'), '-'))
      .toJDate());
  print(JDate.parse('1399/09/09 13:27:00'));
  print(JDate.parse('1399-09-09 13:27:00'));
  print(JDate.parse('۱۳۹۹/۰۹/۰۹'));
  print(JDate.parse('1399/02/13'));
  print(JDate.parse(JDate(1378).toString())); //toString can be parsed back
  
  // Other Methods
  print('\n---Other Methods---');
  print(JDate(1377, 12).toDateTime());
  print(JDate(1377, 12).add(Duration(days: 1, seconds: 24)));
  print(JDate(1377, 12).subtract(Duration(days: 1, seconds: 24)));
  print(JDate(1377, 12).subtract(Duration(days: 1, seconds: 24)));
  print(JDate(1377, 12).difference(JDate(1377, 11)));
  print(JDate(1377, 12).toIso8601String());
  print(JDate(1377, 12).toUtc());
  print(JDate(1377, 12).toLocal());
  print(JDate(1377, 12).compareTo(JDate(1377, 11)));

  //Compare
  JDate(1377, 12, 11) > JDate(1377, 12, 11); //false
  JDate(1377, 12, 11) < JDate(1377, 12, 11); //false
  JDate(1377, 12, 11) <= JDate(1377, 12, 11); //true
  JDate(1378, 12, 11) >= JDate(1377, 12, 11); //true
  JDate(1377, 12, 11) == JDate(1377, 12, 11); //true
  JDate(1377, 12, 11).isAtSameMomentAs(JDate(1377, 12, 11, 10)); //false
  JDate(1377, 10, 11).isBefore(JDate(1377, 12, 11)); //true
  JDate(1377, 10, 11).isAfter(JDate(1377, 12, 11)); //false
}
