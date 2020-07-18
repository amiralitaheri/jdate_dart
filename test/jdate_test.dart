import 'package:jdate/jdate.dart';
import 'package:test/test.dart';

void main() {
  group('Now Constructor', () {
    test('Parameter Test', () {
      final jDate = JDate.now();
      final date = DateTime.now();

      //year, month, day are not equal
      assert(jDate.year != date.year);

      expect(jDate.hour, date.hour);
      expect(jDate.minute, date.minute);
      expect(jDate.second, date.second);
      expect(jDate.isUtc, date.isUtc);
      expect(jDate.timeZoneName, date.timeZoneName);
      expect(jDate.timeZoneOffset, date.timeZoneOffset);
    });
  });

  group('Main Constructor', () {
    test('Full Date', () {
      final jDate = JDate(1378, 12, 18);
      expect(jDate.year, 1378);
      expect(jDate.month, 12);
      expect(jDate.day, 18);
      expect(jDate.weekday, 4);
      expect(jDate.microsecond, 0);
      expect(jDate.millisecond, 0);
      expect(jDate.second, 0);
      expect(jDate.minute, 0);
      expect(jDate.hour, 0);
    });

    test('Full Date and Time', () {
      final jDate = JDate(1395, 1, 31, 21, 30, 15, 250, 550);
      expect(jDate.year, 1395);
      expect(jDate.month, 1);
      expect(jDate.day, 31);
      expect(jDate.weekday, 3);
      expect(jDate.hour, 21);
      expect(jDate.minute, 30);
      expect(jDate.second, 15);
      expect(jDate.millisecond, 250);
      expect(jDate.microsecond, 550);
    });

    test('Only Year', () {
      expect(JDate(1377).year, 1377);
      expect(JDate(1399).year, 1399);
    });
  });

  group('fromDateTime Constructor', () {
    test('Full Date', () {
      final jDate = JDate.fromDateTime(DateTime(1995, 12, 31));
      expect(jDate.year, 1374);
      expect(jDate.month, 10);
      expect(jDate.day, 10);
      expect(jDate.weekday, 1);
      expect(jDate.microsecond, 0);
      expect(jDate.millisecond, 0);
      expect(jDate.second, 0);
      expect(jDate.minute, 0);
      expect(jDate.hour, 0);
    });

    test('Full Date and Time', () {
      final jDate =
          JDate.fromDateTime(DateTime(1990, 5, 10, 22, 36, 12, 110, 750));
      expect(jDate.year, 1369);
      expect(jDate.month, 2);
      expect(jDate.day, 20);
      expect(jDate.weekday, 5);
      expect(jDate.hour, 22);
      expect(jDate.minute, 36);
      expect(jDate.second, 12);
      expect(jDate.millisecond, 110);
      expect(jDate.microsecond, 750);
    });

    test('Year test', () {
      expect(JDate.fromDateTime(DateTime.now()).year, JDate.now().year);
      expect(JDate.fromDateTime(DateTime(1720)).year, 1098);
      expect(JDate.fromDateTime(DateTime(2000)).year, 1378);
      expect(JDate.fromDateTime(DateTime(2200)).year, 1578);
 
      for (var i = 1500; i < 2200; ++i) {
        expect(JDate.fromDateTime(DateTime(i)).year, i - 622);
      }
    });
  });

//  group('parse', () {
//    test('2012-02-27 13:27:00 test', () {
//      var jDate = DateTime.parse('2012-02-27 13:27:00').toJDate();
//      expect(jDate.year, 1390);
//      expect(jDate.month, 12);
//      expect(jDate.day, 8);
//      expect(jDate.weekday, 0);
//    });
//  });

  group('gregorianToJalali', () {
    [
      [1998, 6, 18, 1377, 3, 28],
      [2012, 6, 18, 1391, 3, 29],
      [2020, 7, 16, 1399, 4, 26],
      [2020, 2, 20, 1398, 12, 1],
      [2222, 2, 22, 1600, 12, 3],
    ].forEach((date) {
      test('${date[0]}-${date[1]}-${date[2]}', () {
        expect(
          JDate.gregorianToJalali(date[0], date[1], date[2]),
          {'year': date[3], 'month': date[4], 'day': date[5]},
        );
      });
    });
  });

  group('jalaliToGregorian', () {
    [
      [1377, 3, 28, 1998, 6, 18],
      [1399, 3, 28, 2020, 6, 17],
      [1400, 1, 1, 2021, 3, 21],
      [1414, 4, 14, 2035, 7, 5],
      [1555, 5, 5, 2176, 7, 26],
    ].forEach((date) {
      test('${date[0]}-${date[1]}-${date[2]}', () {
        expect(
          JDate.jalaliToGregorian(date[0], date[1], date[2]),
          {'year': date[3], 'month': date[4], 'day': date[5]},
        );
      });
    });
  });

  group('Leap year', () {
    var leapYears = [
      1210,
      1214,
      1218,
      1222,
      1226,
      1230,
      1234,
      1238,
      1243,
      1247,
      1251,
      1255,
      1259,
      1263,
      1267,
      1271,
      1276,
      1280,
      1284,
      1288,
      1292,
      1296,
      1300,
      1304,
      1309,
      1313,
      1317,
      1321,
      1325,
      1329,
      1333,
      1337,
      1342,
      1346,
      1350,
      1354,
      1358,
      1362,
      1366,
      1370,
      1375,
      1379,
      1383,
      1387,
      1391,
      1395,
      1399,
      1403,
      1408,
      1412,
      1416,
      1420,
      1424,
      1428,
      1432,
      1436,
      1441,
      1445,
      1449,
      1453,
      1457,
      1461,
      1465,
      1469,
      1474,
      1478,
      1482,
      1486,
      1490,
      1494,
      1498,
    ];

    for (var i = 1206; i < 1499; i++) {
      test('$i.isLeapYear()', () {
        expect(JDate(i, 12).isLeapYear(), leapYears.contains(i));
      });
    }
  });

  group('MonthLength', () {
    var months = [31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29];
    for (var i = 0; i < months.length; ++i) {
      test('Month $i', () {
        expect(JDate(1397, i + 1).getMonthLength(), months[i]);
      });
    }
    test('Month 12 Leap', () {
      expect(JDate(1399, 12).getMonthLength(), 30);
    });
  });
}
