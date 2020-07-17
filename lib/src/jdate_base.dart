import 'consts.dart';
import 'number_extensions.dart';
import 'string_extensions.dart';

class JDate {
  int _microsecondsSinceEpoch;
  int _millisecondsSinceEpoch;
  int _microsecond;
  int _millisecond;
  int _second;
  int _minute;
  int _hour;
  int _day;
  int _month;
  int _year;
  Duration _timeZoneOffset;
  String _timeZoneName;
  int _weekDay;

  int get microsecondsSinceEpoch => _microsecondsSinceEpoch;

  set microsecondsSinceEpoch(int microsecondsSinceEpoch) {
    var gregorian = DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch);
    _setFromGregorian(gregorian);
  }

  int get millisecondsSinceEpoch => _millisecondsSinceEpoch;

  set millisecondsSinceEpoch(int millisecondsSinceEpoch) {
    var gregorian = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    _setFromGregorian(gregorian);
  }

  int get microsecond => _microsecond;

  set microsecond(int microsecond) {
    if (microsecond >= 0 && microsecond < 1000) {
      _microsecondsSinceEpoch += -_microsecond + microsecond;
      _microsecond = microsecond;
    } else {
      throw 'microsecond number out of range';
    }
  }

  int get millisecond => _millisecond;

  set millisecond(int millisecond) {
    if (millisecond >= 0 && millisecond < 1000) {
      _microsecondsSinceEpoch += 1000 * (-_millisecond + millisecond);
      _millisecondsSinceEpoch += -_millisecond + millisecond;
      _millisecond = millisecond;
    } else {
      throw 'millisecond number out of range';
    }
  }

  int get second => _second;

  set second(int second) {
    if (second >= 0 && second < 60) {
      _microsecondsSinceEpoch += 1000000 * (-_second + second);
      _millisecondsSinceEpoch += 1000 * (-_second + second);
      _second = second;
    } else {
      throw 'second number out of range';
    }
  }

  int get minute => _minute;

  set minute(int minute) {
    if (minute >= 0 && minute < 60) {
      _microsecondsSinceEpoch += 60 * 1000000 * (-_minute + minute);
      _millisecondsSinceEpoch += 60 * 1000 * (-_minute + minute);
      _minute = minute;
    } else {
      throw 'minute number out of range';
    }
  }

  int get hour => _hour;

  set hour(int hour) {
    if (hour >= 0 && hour < 60) {
      _microsecondsSinceEpoch += 60 * 60 * 1000000 * (-_hour + hour);
      _millisecondsSinceEpoch += 60 * 60 * 1000 * (-_hour + hour);
      _hour = hour;
    } else {
      throw 'hour number out of range';
    }
  }

  int get day => _day;

  set day(int day) {
    if (day > 0 && day <= getMonthLength()) {
      _day = day;
      var gd = jalaliToGregorian(
        _year,
        _month,
        _day,
      );
      var gregorian = DateTime(
        gd['year'],
        gd['month'],
        gd['day'],
        _hour,
        _minute,
        _second,
        _millisecond,
        _microsecond,
      );
      _millisecondsSinceEpoch = gregorian.millisecondsSinceEpoch;
      _microsecondsSinceEpoch = gregorian.microsecondsSinceEpoch;
      _weekDay = gregorian.weekday - 1 % 7;
    } else {
      throw 'day number out of range';
    }
  }

  int get month => _month;

  set month(int month) {
    if (month > 0 && month <= 12) {
      _month = month;
      var gd = jalaliToGregorian(
        _year,
        _month,
        _day,
      );
      var gregorian = DateTime(
        gd['year'],
        gd['month'],
        gd['day'],
        _hour,
        _minute,
        _second,
        _millisecond,
        _microsecond,
      );
      _millisecondsSinceEpoch = gregorian.millisecondsSinceEpoch;
      _microsecondsSinceEpoch = gregorian.microsecondsSinceEpoch;
      _weekDay = gregorian.weekday - 1 % 7;
    } else {
      throw 'month number out of range';
    }
  }

  int get year => _year;

  set year(int year) {
    if (year > 0) {
      _year = year;
      var gd = jalaliToGregorian(
        _year,
        _month,
        _day,
      );
      var gregorian = DateTime(
        gd['year'],
        gd['month'],
        gd['day'],
        _hour,
        _minute,
        _second,
        _millisecond,
        _microsecond,
      );
      _millisecondsSinceEpoch = gregorian.millisecondsSinceEpoch;
      _microsecondsSinceEpoch = gregorian.microsecondsSinceEpoch;
      _weekDay = gregorian.weekday - 1 % 7;
    } else {
      throw 'year number out of range';
    }
  }

  int get weekDay => _weekDay;

  Duration get timeZoneOffset => _timeZoneOffset;

  String get timeZoneName => _timeZoneName;

  JDate(
    int year, [
    int month = 1,
    int day = 1,
    this._hour = 0,
    this._minute = 0,
    this._second = 0,
    this._millisecond = 0,
    this._microsecond = 0,
  ]) {
    var gregorian = DateTime(
        year, month, day, _hour, _minute, _second, _millisecond, _microsecond);
    _timeZoneName = gregorian.timeZoneName;
    _timeZoneOffset = gregorian.timeZoneOffset;
    if (gregorian.millisecondsSinceEpoch > 0) {
      var jalali = gregorianToJalali(year, month, day);
      _year = jalali['year'];
      _month = jalali['month'];
      _day = jalali['day'];
    } else {
      _year = year;
      _month = month;
      _day = day;
      var greg = jalaliToGregorian(year, month, day);
      gregorian = DateTime(greg['year'], greg['month'], greg['day'], _hour,
          _minute, _second, _millisecond, _microsecond);
    }
    _weekDay = gregorian.weekday - 1 % 7;
    _millisecondsSinceEpoch = gregorian.millisecondsSinceEpoch;
    _microsecondsSinceEpoch = gregorian.microsecondsSinceEpoch;
  }

  JDate.fromMicrosecondsSinceEpoch(int microsecondsSinceEpoch) {
    var gregorian = DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch);
    _setFromGregorian(gregorian);
  }

  JDate.fromMillisecondsSinceEpoch(int millisecondsSinceEpoch) {
    var gregorian = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    _setFromGregorian(gregorian);
  }

  JDate.utc(
    int year, [
    int month = 1,
    int day = 1,
    this._hour = 0,
    this._minute = 0,
    this._second = 0,
    this._millisecond = 0,
    this._microsecond = 0,
  ]) {
    var gregorian = DateTime.utc(
        year, month, day, _hour, _minute, _second, _millisecond, _microsecond);
    _timeZoneName = gregorian.timeZoneName;
    _timeZoneOffset = gregorian.timeZoneOffset;
    if (gregorian.millisecondsSinceEpoch > 0) {
      var jalali = gregorianToJalali(year, month, day);
      _year = jalali['year'];
      _month = jalali['month'];
      day = jalali['day'];
    } else {
      _year = year;
      _month = month;
      _day = day;
      var greg = jalaliToGregorian(year, month, day);
      gregorian = DateTime.utc(greg['year'], greg['month'], greg['day'], _hour,
          _minute, _second, _millisecond, _microsecond);
    }
    _weekDay = gregorian.weekday - 1 % 7;
    _millisecondsSinceEpoch = gregorian.millisecondsSinceEpoch;
    _microsecondsSinceEpoch = gregorian.microsecondsSinceEpoch;
  }

  JDate.now() {
    var gregorian = DateTime.now();
    _setFromGregorian(gregorian);
  }

  JDate.parse(String string) {
    string = string.numbersToEnglish().replaceAll(RegExp(r'[/\\]'), '-');
    var date = DateTime.tryParse(string);
    if (date == null) {
      throw 'Can\'t parse string';
    }
    if (date.millisecondsSinceEpoch > 0) {
      _setFromGregorian(date);
    }
    if (date.millisecondsSinceEpoch < 0) {
      var gdt = JDate.jalaliToGregorian(date.year, date.month, date.day);
      var greg = DateTime(gdt['year'], gdt['month'], gdt['day'], date.hour,
          date.minute, date.second, date.millisecond);
      _setFromGregorian(greg);
    }
  }

  int getShortYear() => (_year >= 1300 && _year < 1400)
      ? int.parse(_year.toString().substring(2))
      : int.parse(_year.toString().substring(1));

  bool isLeapYear() => _year % 33 % 4 - 1 == (_year % 33 * .05).floor();

  int setMonth(int month, int day) {
    if (month >= 0 && month <= 11) {
      _month = month;
      if (day != null) {
        if (day > 0 && day <= 31) {
          _day = day;
        } else {
          throw 'Date number out of range';
        }
      }
      var gd = jalaliToGregorian(
        _year,
        _month,
        _day,
      );
      var gregorian = DateTime(
        gd['year'],
        gd['month'],
        gd['day'],
        _hour,
        _minute,
        _second,
        _millisecond,
        _microsecond,
      );
      _millisecondsSinceEpoch = gregorian.millisecondsSinceEpoch;
      _microsecondsSinceEpoch = gregorian.microsecondsSinceEpoch;
      _weekDay = gregorian.weekday - 1 % 7;
      return _millisecondsSinceEpoch;
    } else {
      throw 'Month number out of range';
    }
  }

  int setFullYear(int year, int month, int day) {
    if (year >= 1000 && year <= 9999) {
      year = year;
      if (month != null) {
        if (month >= 0 && month <= 11) {
          _month = month;
        } else {
          throw 'Month number out of range';
        }
      }
      if (day != null) {
        if (day > 0 && day <= 31) {
          _day = day;
        } else {
          throw 'Day number out of range';
        }
      }
      var gd = jalaliToGregorian(
        year,
        month,
        day,
      );
      var gregorian = DateTime(
        gd['year'],
        gd['month'],
        gd['day'],
        _hour,
        _minute,
        _second,
        _millisecond,
        _microsecond,
      );
      _millisecondsSinceEpoch = gregorian.millisecondsSinceEpoch;
      _microsecondsSinceEpoch = gregorian.microsecondsSinceEpoch;
      _weekDay = gregorian.weekday - 1 % 7;
      return _millisecondsSinceEpoch;
    } else {
      throw 'Year number out of range';
    }
  }

  /// set Hour and optionally Minute, Second, Millisecond, Microsecond
  /// if `null` nothing change
  ///
  /// returns `millisecondsSinceEpoch`
  int setHours(int hour, [int min, int sec, int ms, int mis]) {
    var gregorian = DateTime(
      _year,
      _month,
      _day,
      hour ?? _hour,
      min ?? _minute,
      sec ?? _second,
      ms ?? _millisecond,
      mis ?? _microsecond,
    );
    _hour = gregorian.hour;
    _minute = gregorian.minute;
    _second = gregorian.second;
    _millisecond = gregorian.millisecond;
    _microsecond = gregorian.microsecond;

    _millisecondsSinceEpoch = gregorian.millisecondsSinceEpoch;
    _microsecondsSinceEpoch = gregorian.microsecondsSinceEpoch;
    return _millisecondsSinceEpoch;
  }

  /// set Milliseconds of date
  /// if `null` nothing change
  ///
  /// returns `millisecondsSinceEpoch`
  int setMilliseconds(int ms, [int mis]) {
    var gregorian = DateTime(
      _year,
      _month,
      _day,
      _hour,
      _minute,
      _second,
      ms ?? _millisecond,
      mis ?? _microsecond,
    );
    _millisecond = gregorian.millisecond;
    _microsecond = gregorian.microsecond;

    _millisecondsSinceEpoch = gregorian.millisecondsSinceEpoch;
    _microsecondsSinceEpoch = gregorian.microsecondsSinceEpoch;
    return _millisecondsSinceEpoch;
  }

  /// set Minute and optionally Second, Millisecond
  /// if `null` nothing change
  ///
  /// returns `millisecondsSinceEpoch`
  int setMinutes(int min, [int sec, int ms, int mis]) {
    var gregorian = DateTime(
      _year,
      _month,
      _day,
      _hour,
      min ?? _minute,
      sec ?? _second,
      ms ?? _millisecond,
      mis ?? _microsecond,
    );
    _minute = gregorian.minute;
    _second = gregorian.second;
    _millisecond = gregorian.millisecond;
    _microsecond = gregorian.microsecond;

    _millisecondsSinceEpoch = gregorian.millisecondsSinceEpoch;
    _microsecondsSinceEpoch = gregorian.microsecondsSinceEpoch;
    return _millisecondsSinceEpoch;
  }

  /// set Second and optionally Millisecond
  /// if `null` nothing change
  ///
  /// returns `millisecondsSinceEpoch`
  int setSeconds(int sec, [int ms, int mis]) {
    var gregorian = DateTime(
      _year,
      _month,
      _day,
      _hour,
      _minute,
      sec ?? _second,
      ms ?? _millisecond,
      mis ?? _microsecond,
    );
    _second = gregorian.second;
    _millisecond = gregorian.millisecond;
    _microsecond = gregorian.microsecond;

    _millisecondsSinceEpoch = gregorian.millisecondsSinceEpoch;
    _microsecondsSinceEpoch = gregorian.microsecondsSinceEpoch;
    return _millisecondsSinceEpoch;
  }

  int setTime(int ms) {
    var gregorian = DateTime.fromMillisecondsSinceEpoch(ms);
    _setFromGregorian(gregorian);
    return _millisecondsSinceEpoch;
  }

  /// returns number of days in that month
  int getMonthLength() {
    if (_month <= 6) {
      return 31;
    } else if (_month == 12) {
      return isLeapYear() ? 30 : 29;
    } else {
      return 30;
    }
  }

  String echo([String format = 'l، d F Y ساعت H:i:s']) {
    var leapYear = isLeapYear();
    var jw = _weekDay;
    var jy = getShortYear();
    var jtz = _timeZoneName;

    return format
        .replaceAll('a', (_hour < 12) ? 'ق.ظ' : 'ب.ظ')
        .replaceAll('b', ((_month) / 3.1).floor().toString())
        .replaceAll('d', _withZero(_day))
        .replaceAll(
          'f',
          jalaliSeasons[((_month) / 3.1).floor()]['long'],
        )
        .replaceAll(
          'g',
          _hour <= 12 ? _hour.toString() : (_hour - 12).toString(),
        )
        .replaceAll(
          'h',
          _hour <= 12 ? _withZero(_hour) : _withZero(_hour - 12),
        )
        .replaceAll('i', _withZero(_minute))
        .replaceAll('j', _day.toString())
        .replaceAll('l', jalaliWeeks[jw]['long'])
        .replaceAll('m', _withZero(_month))
        .replaceAll('n', (_month + 1).toString())
        .replaceAll('s', _withZero(_second))
        .replaceAll(
          't',
          (_month) != 12
              ? (31 - ((_month) / 6.5).floor()).toString()
              : (leapYear ? 1 : 0 + 29).toString(),
        )
        .replaceAll('u', _millisecond.toString())
        .replaceAll('v', jy.toPersianWords())
        .replaceAll('w', jw.toString())
        .replaceAll('y', jy.toString())
        .replaceAll('A', (_hour < 12) ? 'قبل از ظهر' : 'بعد از ظهر')
        .replaceAll('D', jalaliWeeks[jw]['short'])
        .replaceAll('F', jalaliMonths[_month - 1]['long'])
        .replaceAll('G', _hour.toString())
        .replaceAll('H', _withZero(_hour))
        .replaceAll('J', _day.toPersianWords())
        .replaceAll('L', leapYear.toString())
        .replaceAll('M', jalaliMonths[_month - 1]['short'])
        .replaceAll('O', jtz)
        .replaceAll('V', _year.toPersianWords())
        .replaceAll('Y', _year.toString());
  }

  void _setFromGregorian(DateTime gregorian) {
    _microsecond = gregorian.microsecond;
    _millisecond = gregorian.millisecond;
    _second = gregorian.second;
    _minute = gregorian.minute;
    _hour = gregorian.hour;
    _weekDay = gregorian.weekday - 1 % 7;
    _millisecondsSinceEpoch = gregorian.millisecondsSinceEpoch;
    _microsecondsSinceEpoch = gregorian.microsecondsSinceEpoch;

    _timeZoneName = gregorian.timeZoneName;
    _timeZoneOffset = gregorian.timeZoneOffset;

    var jalali =
        gregorianToJalali(gregorian.year, gregorian.month, gregorian.day);
    _year = jalali['year'];
    _month = jalali['month'];
    _day = jalali['day'];
  }

  @override
  String toString() => echo();

  /// Jalali to Gregorian Conversion
  /// Copyright (C) 2000  Roozbeh Pournader and Mohammad Toossi
  static Map jalaliToGregorian(var jy, var jm, var jd) {
    jy -= 979;
    jm -= 1;
    jd -= 1;
    const gDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    const jDaysInMonth = [31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29];

    var jDayNo = 365 * jy + (jy / 33).floor() * 8 + ((jy % 33 + 3) / 4).floor();
    for (var i = 0; i < jm; ++i) {
      jDayNo += jDaysInMonth[i];
    }

    jDayNo += jd;

    var gDayNo = jDayNo + 79;

    var gy = 1600 + 400 * (gDayNo / 146097).floor();
    gDayNo = gDayNo % 146097;

    var leap = true;
    if (gDayNo >= 36525) {
      gDayNo--;
      gy += 100 * (gDayNo / 36524).floor();
      gDayNo = gDayNo % 36524;

      if (gDayNo >= 365) {
        gDayNo++;
      } else {
        leap = false;
      }
    }

    gy += 4 * (gDayNo / 1461).floor();
    gDayNo %= 1461;

    if (gDayNo >= 366) {
      leap = false;

      gDayNo--;
      gy += (gDayNo / 365).floor();
      gDayNo = gDayNo % 365;
    }
    var i;
    for (i = 0; gDayNo >= gDaysInMonth[i] + ((i == 1 && leap) ? 1 : 0); i++) {
      gDayNo -= gDaysInMonth[i] + ((i == 1 && leap) ? 1 : 0);
    }
    var gm = i + 1;
    var gd = gDayNo + 1;

    return {'year': gy, 'month': gm, 'day': gd};
  }

  /// Gregorian to Jalali Conversion
  /// Copyright (C) 2000  Roozbeh Pournader and Mohammad Toossi
  static Map<String, int> gregorianToJalali(int gy, int gm, int gd) {
    gy -= 1600;
    gm -= 1;
    gd -= 1;

    const gDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    const jDaysInMonth = [31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29];

    var gDayNo = 365 * gy +
        ((gy + 3) / 4).floor() -
        ((gy + 99) / 100).floor() +
        ((gy + 399) / 400).floor();

    for (var i = 0; i < gm; ++i) {
      gDayNo += gDaysInMonth[i];
    }
    if (gm > 1 && ((gy % 4 == 0 && gy % 100 != 0) || (gy % 400 == 0))) gDayNo++;
    gDayNo += gd;

    var jDayNo = gDayNo - 79;

    var jNp = (jDayNo / 12053).floor();
    jDayNo = jDayNo % 12053;

    var jy = 979 + 33 * jNp + 4 * (jDayNo / 1461).floor();

    jDayNo %= 1461;

    if (jDayNo >= 366) {
      jy += ((jDayNo - 1) / 365).floor();
      jDayNo = (jDayNo - 1) % 365;
    }
    var i = 0;
    for (i; i < 11 && jDayNo >= jDaysInMonth[i]; ++i) {
      jDayNo -= jDaysInMonth[i];
    }
    var jm = i + 1;
    var jd = jDayNo + 1;
    return {'year': jy, 'month': jm, 'day': jd};
  }

  static String _withZero(int num) =>
      (num < 10) ? '0' + num.toString() : num.toString();

  static Map hijriToGregorian(int hy, int hm, int hd) {
    var i = ((hy - 1) * 12) + 1 + (hm - 1) - 16260;
    var julianDate = hd + _ummalquraDataIndex(i - 1) - 1 + 2400000;
    var z = (julianDate + 0.5).floor();
    var a = ((z - 1867216.25) / 36524.25).floor();
    a = z + 1 + a - (a / 4).floor();
    var b = a + 1524;
    var c = ((b - 122.1) / 365.25).floor();
    var d = (365.25 * c).floor();
    var e = ((b - d) / 30.6001).floor();
    var day = b - d - (e * 30.6001).floor();
    var month = e - (e > 13.5 ? 13 : 1);
    var year = c - (month > 2.5 ? 4716 : 4715);
    if (year <= 0) {
      year--;
    }
    return {'year': year, 'month': month, 'day': day};
  }

  static int _ummalquraDataIndex(int index) {
    if (index < 0 || index >= ummAlquraDateArray.length) {
      throw ArgumentError(
          'Valid date should be between 1356 AH (14 March 1937 CE) to 1500 AH (16 November 2077 CE)');
    }
    return ummAlquraDateArray[index];
  }

  static Map gregorianToHijri(int year, int month, int day) {
    //This code the modified version of R.H. van Gent Code, it can be found at http://www.staff.science.uu.nl/~gent0113/islam/ummalqura.htm
    var m = month;
    var y = year;

    // append January and February to the previous year (i.e. regard March as
    // the first month of the year in order to simplify leapday corrections)
    if (m < 3) {
      y -= 1;
      m += 12;
    }

    // determine offset between Julian and Gregorian calendar
    var a = (y / 100).floor();
    var jgc = a - (a / 4.0).floor() - 2;

    // compute Chronological Julian Day Number (CJDN)
    var cjdn = (365.25 * (y + 4716)).floor() +
        (30.6001 * (m + 1)).floor() +
        day -
        jgc -
        1524;

    a = ((cjdn - 1867216.25) / 36524.25).floor();
    jgc = a - (a / 4.0).floor() + 1;
    var b = cjdn + jgc + 1524;
    var c = ((b - 122.1) / 365.25).floor();
    var d = (365.25 * c).floor();
    month = ((b - d) / 30.6001).floor();
    day = (b - d) - (30.6001 * month).floor();

    if (month > 13) {
      c += 1;
      month -= 12;
    }

    month -= 1;
    year = c - 4716;

    // compute Modified Chronological Julian Day Number (MCJDN)
    var mcjdn = cjdn - 2400000;

    // the MCJDN's of the start of the lunations in the Umm al-Qura calendar are stored in 'islamcalendar_dat.js'
    var i;
    for (i = 0; i < ummAlquraDateArray.length; i++) {
      if (_ummalquraDataIndex(i) > mcjdn) break;
    }

    // compute and output the Umm al-Qura calendar date
    var iln = i + 16260;
    var ii = ((iln - 1) / 12).floor();
    var iy = ii + 1;
    var im = iln - 12 * ii;
    var id = mcjdn - _ummalquraDataIndex(i - 1) + 1;

    return {'year': iy, 'month': im, 'day': id};
  }

  static Map hijriToJalali(int year, int month, int day) {
    var gregorian = hijriToGregorian(year, month, day);
    return gregorianToJalali(
        gregorian['year'], gregorian['month'], gregorian['day']);
  }

  static Map jalaliToHijri(int year, int month, int day) {
    var gregorian = jalaliToGregorian(year, month, day);
    return gregorianToHijri(
        gregorian['year'], gregorian['month'], gregorian['day']);
  }

// todo: JDate.fromGregorian();
// todo: JDate.fromHijri();
}
