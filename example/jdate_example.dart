import 'package:jdate/jdate.dart';

void main() {
  // gregorian date constructor
  print('\nGregorian date constructor');
  print(DateTime.now().toJDate());
  print(DateTime(2020).toJDate());
  print(DateTime(2020, 7).toJDate());
  print(DateTime(2020, 7, 16).toJDate());
  print(DateTime(2020, 7, 16, 12).toJDate());
  print(DateTime(2020, 7, 16, 12, 18).toJDate());
  print(DateTime(2020, 7, 16, 12, 18, 30).toJDate());
  print(DateTime(2020, 7, 16, 12, 18, 30, 450).toJDate());

  // jalali date constructor
  print('\nJalali date constructor');
  print(JDate.now());
  print(JDate(1399));
  print(JDate(1399, 4));
  print(JDate(1399, 4, 15));
  print(JDate(1399, 4, 15, 20));
  print(JDate(1399, 4, 15, 20, 25));
  print(JDate(1399, 4, 15, 20, 25, 30));
  print(JDate(1399, 4, 15, 20, 25, 30, 650));

  //custom format
  print('\nCustom format');
  print(JDate.now().echo('l، d F V ساعت H:i:s'));

  //useful static methods
  print('\nStatic methods');
  print(JDate.gregorianToJalali(2020, 7, 16));
  print(JDate.jalaliToGregorian(1399, 4, 26));
  print(JDate.gregorianToHijri(2020, 7, 16));
  print(JDate.hijriToGregorian(1441, 11, 25));
  print(JDate.hijriToJalali(1441, 11, 25));
  print(JDate.jalaliToHijri(1399, 6, 6));

  //useful extension
  print('\nExtension methods');
  print('۱۲۳۴۵۶۷۸۹۰'.numbersToEnglish());
  print(JDate.now().toString().numbersToPersian());
  print(60000000.toPersianWords());
  print((-250).toPersianWords());
  print(550.toPersianWords(true));
  print(DateTime.now().add(Duration(days: 2)).toJDate());

  //parse
  print('\nParse');
  print(DateTime.parse('2012-02-27 13:27:00').toJDate());
  print(DateTime.parse('2012/02/27 13:27:00'.replaceAll(RegExp(r'[/\\]'), '-'))
      .toJDate());
  print(JDate.parse('1399/09/09 13:27:00'));
  print(JDate.parse('1399-09-09 13:27:00'));
  print(JDate.parse('۱۳۹۹/۰۹/۰۹'));
  print(JDate.parse('1399/02/13'));
  print(JDate.parse('1399/02/13 03:14:30'));
  
  //change date
  print(JDate.now().changeTo(year: 1357, second: 10));
}
