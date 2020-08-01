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
      expect(jDate.weekday, 5);
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
      expect(jDate.weekday, 4);
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
      expect(jDate.weekday, 2);
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
      expect(jDate.weekday, 6);
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

  group('Parameters Setter', () {
    test('year', () {});
    test('month', () {});
    test('day', () {});
    test('hour', () {});
    test('minute', () {});
    test('second', () {});
    test('millisecond', () {});
    test('microsecond', () {});
    test('millisecondsSinceEpoch', () {});
    test('microsecondsSinceEpoch', () {});
  });

  group('weekday Parameter', () {
    test('', () {});
  });

  group('timeZoneOffset Parameter', () {
    test('', () {});
  });

  group('timeZoneName Parameter', () {
    test('', () {});
  });

  group('weekdayName Parameter', () {
    test('', () {});
  });

  group('monthName Parameter', () {
    test('', () {});
  });

  group('shortYear Parameter', () {
    test('', () {});
  });

  group('utc', () {
    test('', () {});
  });

  group('Second to Date Constructor', () {
    test('fromMicrosecondsSinceEpoch', () {});
    test('fromMillisecondsSinceEpoch', () {});
  });

  group('Parser', () {
    [
      ['1386-06-27 13:27:00', 1386, 06, 27, 13, 27, 00, 0, 0],
      ['1386-06-27 13:27:00.123456789z', 1386, 06, 27, 13, 27, 00, 123, 456],
      ['1386-06-27 13:27:00,123456789z', 1386, 06, 27, 13, 27, 00, 123, 456],
      ['13860627 13:27:00', 1386, 06, 27, 13, 27, 00, 0, 0],
      ['13860627T132700', 1386, 06, 27, 13, 27, 00, 0, 0],
      ['13860627', 1386, 06, 27, 00, 00, 00, 0, 0],
      ['+13860627', 1386, 06, 27, 00, 00, 00, 0, 0],
      ['1386-06-27T14Z', 1386, 06, 27, 14, 00, 00, 0, 0],
      ['1386-06-27T14+00:00', 1386, 06, 27, 14, 00, 00, 0, 0],
      ['-123450101 00:00:00 Z', -12345, 01, 01, 00, 00, 00, 0, 0],
      ['1389-02-27T14:00:00-0500', 1389, 02, 27, 19, 00, 00, 0, 0],
      ['1389-02-27T19:00:00Z', 1389, 02, 27, 19, 00, 00, 0, 0],
      ['1399/09/10 13:27:00', 1399, 09, 10, 13, 27, 00, 0, 0],
      ['۱۳۹۹/۱۱/۰۹', 1399, 11, 09, 00, 00, 00, 0, 0],
    ].forEach((element) {
      test('Parse (${element[0]})', () {
        final date = JDate.tryParse(element[0]);
        expect(date.year, element[1]);
        expect(date.month, element[2]);
        expect(date.day, element[3]);
        expect(date.hour, element[4]);
        expect(date.minute, element[5]);
        expect(date.second, element[6]);
        expect(date.millisecond, element[7]);
        expect(date.microsecond, element[8]);
      });
      test('Try Parse (${element[0]})', () {
        final date = JDate.tryParse(element[0]);
        expect(date.year, element[1]);
        expect(date.month, element[2]);
        expect(date.day, element[3]);
        expect(date.hour, element[4]);
        expect(date.minute, element[5]);
        expect(date.second, element[6]);
        expect(date.millisecond, element[7]);
        expect(date.microsecond, element[8]);
      });
    });

    test('Bad Format', () {
      expect(JDate.parse('1386-06-27  13:27:00'), FormatException);
      expect(JDate.tryParse('1386-06-27  13:27:00'), null);
    });

    test('Parse Back toString', () {
      final date = JDate.parse(JDate(1378, 11, 27, 11, 00, 21).toString());
      expect(date.year, 1378);
      expect(date.month, 11);
      expect(date.day, 27);
      expect(date.hour, 11);
      expect(date.minute, 00);
      expect(date.second, 21);
    });

    test('TimeZone Test', () {});
    test('Utc Test', () {});
  });

  group('changeTo', () {
    test('', () {});
  });

  group('echo', () {
    test('', () {});
  });

  group('Change Date (Add, Sub)', () {
    test('subtract', () {});
    test('add', () {});
  });

  group('Compare Dates', () {
    test('compareTo', () {});
    test('difference', () {});
    test('isAfter', () {});
    test('isBefore', () {});
    test('isAtSameMomentAs', () {});
  });

  group('toIso8601String', () {
    test('', () {});
  });

  group('toUtc', () {
    test('', () {});
  });

  group('toLocal', () {
    test('', () {});
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
        expect(JDate(i, 12).isLeapYear, leapYears.contains(i));
      });
    }
  });

  group('MonthLength', () {
    var months = [31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29];
    for (var i = 0; i < months.length; ++i) {
      test('Month $i', () {
        expect(JDate(1397, i + 1).monthLength, months[i]);
      });
    }
    test('Month 12 Leap', () {
      expect(JDate(1399, 12).monthLength, 30);
    });
  });
}
