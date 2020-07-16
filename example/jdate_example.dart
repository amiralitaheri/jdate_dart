import 'package:jdate/jdate.dart';

void main() {
  // gregorian date constructor
  print('\nGregorian date constructor');
  print(JDate());
  print(JDate(2020));
  print(JDate(2020, 7));
  print(JDate(2020, 7, 16));
  print(JDate(2020, 7, 16, 12));
  print(JDate(2020, 7, 16, 12, 18));
  print(JDate(2020, 7, 16, 12, 18, 30));
  print(JDate(2020, 7, 16, 12, 18, 30, 450));

  // jalali date constructor
  print('\nJalali date constructor');
  print(JDate());
  print(JDate(1399));
  print(JDate(1399, 4));
  print(JDate(1399, 4, 15));
  print(JDate(1399, 4, 15, 20));
  print(JDate(1399, 4, 15, 20, 25));
  print(JDate(1399, 4, 15, 20, 25, 30));
  print(JDate(1399, 4, 15, 20, 25, 30, 650));

  //custom format
  print('\nCustom format');
  print(JDate().echo('l، d F V ساعت H:i:s'));

  //useful static methods
  print('\nStatic methods');
  print(JDate.numToPersianStr(60, true));

  //useful extension
  print('۱۲۳۴۵۶۷۸۹۰'.numbersToEnglish());
  print(JDate().toString().numbersToPersian());
}
