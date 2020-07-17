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
  bool _isUtc;

  int get microsecondsSinceEpoch => _microsecondsSinceEpoch;

  int get millisecondsSinceEpoch => _millisecondsSinceEpoch;

  int get microsecond => _microsecond;

  int get millisecond => _millisecond;

  int get second => _second;

  int get minute => _minute;

  int get hour => _hour;

  int get day => _day;

  int get month => _month;

  int get year => _year;

  int get weekDay => _weekDay;

  Duration get timeZoneOffset => _timeZoneOffset;

  String get timeZoneName => _timeZoneName;

  bool get isUtc => _isUtc;

  JDate(
    int year, [
    int month = 1,
    int day = 1,
    int hour = 0,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  ]) {
    _internal(
      year,
      month,
      day,
      hour,
      minute,
      second,
      millisecond,
      microsecond,
      false,
    );
  }

  JDate.utc(
    int year, [
    int month = 1,
    int day = 1,
    int hour = 0,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  ]) {
    _internal(
      year,
      month,
      day,
      hour,
      minute,
      second,
      millisecond,
      microsecond,
      true,
    );
  }

  JDate changeTo({
    int year,
    int month,
    int day,
    int hour,
    int minute,
    int second,
    int millisecond,
    int microsecond,
    bool isUtc,
  }) {
    _internal(
      year ?? _year,
      month ?? _month,
      day ?? _day,
      hour ?? _hour,
      minute ?? _minute,
      second ?? _second,
      millisecond ?? _millisecond,
      microsecond ?? _microsecond,
      isUtc ?? _isUtc,
    );
    return this;
  }

  JDate.fromDateTime(DateTime date) {
    var jalali = gregorianToJalali(date.year, date.month, date.day);
    _internal(
      jalali['year'],
      jalali['month'],
      jalali['day'],
      date.hour,
      date.minute,
      date.second,
      date.millisecond,
      date.microsecond,
      date.isUtc,
    );
  }

  JDate.fromMicrosecondsSinceEpoch(int microsecondsSinceEpoch) {
    var gregorian = DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch);
    JDate.fromDateTime(gregorian);
  }

  JDate.fromMillisecondsSinceEpoch(int millisecondsSinceEpoch) {
    var gregorian = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    JDate.fromDateTime(gregorian);
  }

  JDate.now() : this.fromDateTime(DateTime.now());

  JDate.parse(String string) {
    string = string.numbersToEnglish().replaceAll(RegExp(r'[/\\]'), '-');
    var date = DateTime.tryParse(string);
    if (date == null) {
      throw 'Can\'t parse string';
    }
    _internal(
      date.year,
      date.month,
      date.day,
      date.hour,
      date.minute,
      date.second,
      date.millisecond,
      date.microsecond,
      date.isUtc,
    );
  }

  void _internal(
    int year,
    int month,
    int day,
    int hour,
    int minute,
    int second,
    int millisecond,
    int microsecond,
    bool isUtc,
  ) {
    //check boundaries
    assert(month <= 12 && month >= 1, 'Month is in range of 1-12');
    assert(day <= 31 && day >= 1, 'Day is in range of 1-31');
    assert(hour <= 23 && hour >= 0, 'Hour is in range of 0-23');
    assert(minute <= 59 && minute >= 0, 'Minute is in range of 0-59');
    assert(second <= 59 && second >= 0, 'Second is in range of 0-59');
    assert(millisecond <= 999 && millisecond >= 0,
        'Millisecond is in range of 0-999');
    assert(microsecond <= 999 && microsecond >= 0,
        'Microsecond is in range of 0-999');

    //initialize parameters
    _year = year;
    _month = month;
    _day = day;
    _hour = hour;
    _minute = minute;
    _second = second;
    _millisecond = millisecond;
    _microsecond = microsecond;
    _isUtc = isUtc;

    //convert jalali to gregorian to get other parameters
    var greg = jalaliToGregorian(year, month, day);
    DateTime gregorian;
    if (_isUtc) {
      gregorian = DateTime.utc(greg['year'], greg['month'], greg['day'], _hour,
          _minute, _second, _millisecond, _microsecond);
    } else {
      gregorian = DateTime(greg['year'], greg['month'], greg['day'], _hour,
          _minute, _second, _millisecond, _microsecond);
    }

    _timeZoneName = gregorian.timeZoneName;
    _timeZoneOffset = gregorian.timeZoneOffset;
    _weekDay = gregorian.weekday - 1 % 7;
    _millisecondsSinceEpoch = gregorian.millisecondsSinceEpoch;
    _microsecondsSinceEpoch = gregorian.microsecondsSinceEpoch;
  }

  int getShortYear() {
    if (_year >= 1300 && _year < 1400) {
      return int.parse(_year.toString().substring(2));
    } else {
      return _year;
    }
  }

  bool isLeapYear() => _year % 33 % 4 - 1 == (_year % 33 * .05).floor();

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
