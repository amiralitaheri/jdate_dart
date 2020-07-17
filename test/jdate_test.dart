import 'package:jdate/jdate.dart';
import 'package:test/test.dart';

void main() {
  group('Empty constructor', () {
    JDate jDate;

    setUp(() {
      jDate = JDate();
    });

    test('Minute test', () {
      expect(jDate.getMinute(), DateTime.now().minute);
    });

    test('Hour test', () {
      expect(jDate.getHour(), DateTime.now().hour);
    });
  });

  group('Constructor with Gregorian Year', () {
    test('Year 1998 test', () {
      expect(JDate(1998).getFullYear(), 1376);
    });
    test('Year 2020 test', () {
      expect(JDate(2020).getFullYear(), 1398);
    });
  });

  group('Constructor with Jalali Year', () {
    test('Year 1377 test', () {
      expect(JDate(1377).getFullYear(), 1377);
    });
    test('Year 1399 test', () {
      expect(JDate(1399).getFullYear(), 1399);
    });
  });

  group('Constructor with full Gregorian date', () {
    JDate jDate;

    setUp(() {
      jDate = JDate(1998, 6, 18);
    });

    test('1998-6-18 test', () {
      expect(jDate.getFullYear(), 1377);
      expect(jDate.getMonth(), 3);
      expect(jDate.getDate(), 28);
      expect(jDate.getDay(), 3);
    });
  });

  group('Constructor with full Jalali date', () {
    JDate jDate;

    setUp(() {
      jDate = JDate(1377, 3, 27);
    });

    test('1377-3-27 test', () {
      expect(jDate.getFullYear(), 1377);
      expect(jDate.getMonth(), 3);
      expect(jDate.getDate(), 27);
      expect(jDate.getDay(), 2);
    });
  });

  group('Constructor with String', () {
    JDate jDate;

    setUp(() {
      jDate = JDate('2012-02-27 13:27:00');
    });

    test('2012-02-27 13:27:00 test', () {
      expect(jDate.getFullYear(), 1390);
      expect(jDate.getMonth(), 12);
      expect(jDate.getDate(), 8);
      expect(jDate.getDay(), 0);
    });
  });

  group('gregorianToJalali', () {
    test('2012-6-18', () {
      expect(JDate.gregorianToJalali(2012, 6, 18),
          {'year': 1391, 'month': 3, 'date': 29});
    });

    test('1998-6-18', () {
      expect(JDate.gregorianToJalali(1998, 6, 18),
          {'year': 1377, 'month': 3, 'date': 28});
    });

    test('2020-7-16', () {
      expect(JDate.gregorianToJalali(2020, 7, 16),
          {'year': 1399, 'month': 4, 'date': 26});
    });

    test('2020-2-20', () {
      expect(JDate.gregorianToJalali(2020, 2, 20),
          {'year': 1398, 'month': 12, 'date': 1});
    });

    test('2222-2-22', () {
      expect(JDate.gregorianToJalali(2222, 2, 22),
          {'year': 1600, 'month': 12, 'date': 3});
    });
  });

  group('jalaliToGregorian', () {
    test('1377-3-28', () {
      expect(JDate.jalaliToGregorian(1377, 3, 28),
          {'year': 1998, 'month': 6, 'date': 18});
    });

    test('1399-3-28', () {
      expect(JDate.jalaliToGregorian(1399, 3, 28),
          {'year': 2020, 'month': 6, 'date': 17});
    });

    test('1400-1-1', () {
      expect(JDate.jalaliToGregorian(1400, 1, 1),
          {'year': 2021, 'month': 3, 'date': 21});
    });

    test('1414-4-14', () {
      expect(JDate.jalaliToGregorian(1414, 4, 14),
          {'year': 2035, 'month': 7, 'date': 5});
    });

    test('1555-5-5', () {
      expect(JDate.jalaliToGregorian(1555, 5, 5),
          {'year': 2176, 'month': 7, 'date': 26});
    });
  });

  group('withzero function', () {
    test('1', () {
      expect(JDate.withZero(1), '01');
    });

    test('9', () {
      expect(JDate.withZero(9), '09');
    });

    test('10', () {
      expect(JDate.withZero(10), '10');
    });
    test('100', () {
      expect(JDate.withZero(100), '100');
    });
  });
}
