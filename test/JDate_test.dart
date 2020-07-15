import 'package:JDate/JDate.dart';
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
      expect(jDate.getDate(), 27);
      expect(jDate.getDay(), 5);
    });
  });

  group('Constructor with full Jalali date', () {
    JDate jDate;

    setUp(() {
      jDate = JDate(1377, 3, 27);
    });

    test('1998-6-18 test', () {
      expect(jDate.getFullYear(), 1377);
      expect(jDate.getMonth(), 3);
      expect(jDate.getDate(), 27);
      expect(jDate.getDay(), 5);
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
      expect(jDate.getDay(), 2);
    });
  });
}
