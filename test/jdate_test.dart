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
          {'year': date[3], 'month': date[4], 'date': date[5]},
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
          {'year': date[3], 'month': date[4], 'date': date[5]},
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

  //todo: uncomment when هجری implemented :)
//  group('description', (){
//    [
//      [2016, 10, 3, 1438, 1, 1],
//      [2016, 11, 1, 1438, 2, 1],
//      [2016, 12, 1, 1438, 3, 1],
//      [2016, 12, 31, 1438, 4, 1],
//      [2016, 10, 3, 1438, 1, 1],
//      [2016, 11, 1, 1438, 2, 1],
//      [2016, 12, 1, 1438, 3, 1],
//      [2016, 12, 31, 1438, 4, 1],
//      [2017, 1, 30, 1438, 5, 1],
//      [2017, 2, 28, 1438, 6, 1],
//      [2017, 3, 30, 1438, 7, 1],
//      [2017, 4, 28, 1438, 8, 1],
//      [2017, 5, 27, 1438, 9, 1],
//      [2017, 6, 26, 1438, 10, 1],
//      [2017, 7, 25, 1438, 11, 1],
//      [2017, 8, 23, 1438, 12, 1],
//      [2017, 9, 22, 1439, 1, 1],
//      [2017, 10, 21, 1439, 2, 1],
//      [2017, 11, 20, 1439, 3, 1],
//      [2017, 12, 20, 1439, 4, 1],
//      [2018, 1, 19, 1439, 5, 1],
//      [2018, 2, 18, 1439, 6, 1],
//      [2018, 3, 19, 1439, 7, 1],
//      [2018, 4, 18, 1439, 8, 1],
//      [2018, 5, 17, 1439, 9, 1],
//      [2018, 6, 15, 1439, 10, 1],
//      [2018, 7, 15, 1439, 11, 1],
//      [2018, 8, 13, 1439, 12, 1],
//      [2018, 9, 11, 1440, 1, 1],
//      [2018, 10, 11, 1440, 2, 1],
//      [2018, 11, 9, 1440, 3, 1],
//      [2018, 12, 9, 1440, 4, 1],
//      [2019, 1, 8, 1440, 5, 1],
//      [2019, 2, 7, 1440, 6, 1],
//    ].forEach((element) {
//
//    });
//  });
}
