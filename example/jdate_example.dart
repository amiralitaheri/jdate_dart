import 'package:jdate/jdate.dart';

void main() {
  // gregorian date constructor
  print('\nGregorian date constructor');
  print(JDate(2020));
  print(JDate(2020, 7));
  print(JDate(2020, 7, 16));
  print(JDate(2020, 7, 16, 12));
  print(JDate(2020, 7, 16, 12, 18));
  print(JDate(2020, 7, 16, 12, 18, 30));
  print(JDate(2020, 7, 16, 12, 18, 30, 450));

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
  print(60000000.toPersianWords(true));

  //parse
  print('\nParse');
  print(JDate.parse('2012/02/27 13:27:00'));
  print(JDate.parse('2012-02-27 13:27:00'));
  print(JDate.parse('1399/09/09 13:27:00'));
  print(JDate.parse('1399-09-09 13:27:00'));
  print(JDate.parse('۱۳۹۹/۰۹/۰۹'));
  print(JDate.parse('1399/02/13'));
  print(JDate.parse('1399/02/13 03:14:30'));
  print(JDate.parse('2019/05/03 01:02:03'));
}
