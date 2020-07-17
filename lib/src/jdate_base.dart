import 'number_extensions.dart';
import 'string_extensions.dart';

class JDate {
  Map<String, int> _jalali;
  DateTime _gregorian;

  JDate(
      [var year,
      var month,
      var date = 1,
      var hours = 0,
      var minutes = 0,
      var seconds = 0,
      var milliseconds = 0]) {
    _gregorian = DateTime.now();
    if (year != null) {
      if (month == null) {
        if (year.toString().length <= 4) {
          year = year is int ? year : int.parse(year);
          _gregorian = DateTime(year);
          if (_gregorian.millisecondsSinceEpoch < 0) {
            var gd = jalaliToGregorian(year, 1, date);
            _gregorian = DateTime(gd['year'], gd['month'], gd['date'], hours,
                minutes, seconds, milliseconds);
          }
        } else {
          _gregorian = DateTime.tryParse(year.toString());
          if (_gregorian?.millisecondsSinceEpoch == null ||
              _gregorian.millisecondsSinceEpoch < 0) {
//            gregorian = DateTime(parse(year));
            if (_gregorian?.millisecondsSinceEpoch == null ||
                _gregorian.millisecondsSinceEpoch < 0) {
              throw 'Cannot parse date string';
            }
          }
        }
      } else {
        _gregorian =
            DateTime(year, month, date, hours, minutes, seconds, milliseconds);
        if (_gregorian.millisecondsSinceEpoch < 0) {
          var gd = jalaliToGregorian(year, month, date);
          _gregorian = DateTime(gd['year'], gd['month'], gd['date'], hours,
              minutes, seconds, milliseconds);
        }
      }
    }
    setJalali();
  }

  int getDate() => _jalali['date'];

  int getDay() => _gregorian.weekday - 1 % 7;

  int getFullYear() => _jalali['year'];

  int getShortYear() => (_jalali['year'] >= 1300 && _jalali['year'] < 1400)
      ? int.parse(_jalali['year'].toString().substring(2))
      : int.parse(_jalali['year'].toString().substring(1));

  int getHour() => _gregorian.hour;

  int getMilliseconds() => _gregorian.millisecond;

  int getMinute() => _gregorian.minute;

  int getMonth() => _jalali['month'];

  int getSeconds() => _gregorian.second;

  int getTime() => _gregorian.millisecondsSinceEpoch;

  String getTimezone() => _gregorian.timeZoneName;

  int getTimezoneOffset() => _gregorian.timeZoneOffset.inMinutes;

  int isLeapYear([var year]) {
    if (year == null) {
      return isLeapYear(_jalali['year']);
    } else {
      year = (year is int) ? year : int.parse(year);
      return (year % 33 % 4 - 1 == (year % 33 * .05).floor()) ? 1 : 0;
    }
  }

  int setDate(date) {
    if (date > 0 && date <= 31) {
      _jalali['date'] = date;
      var gd =
          jalaliToGregorian(_jalali['year'], _jalali['month'], _jalali['date']);
      _gregorian = DateTime(
          gd['year'],
          gd['month'],
          gd['date'],
          _gregorian.hour,
          _gregorian.minute,
          _gregorian.second,
          _gregorian.millisecond,
          _gregorian.microsecond);
      return _gregorian.millisecondsSinceEpoch;
    } else {
      throw 'Cannot parse date number';
    }
  }

  int setMonth(month, date) {
    if (month >= 0 && month <= 11) {
      _jalali['month'] = month;
      if (date != null) {
        if (date > 0 && date <= 31) {
          _jalali['date'] = date;
        } else {
          throw 'Cannot parse date number';
        }
      }
      var gd =
          jalaliToGregorian(_jalali['year'], _jalali['month'], _jalali['date']);
      _gregorian = DateTime(
          gd['year'],
          gd['month'],
          gd['date'],
          _gregorian.hour,
          _gregorian.minute,
          _gregorian.second,
          _gregorian.millisecond,
          _gregorian.microsecond);
      return _gregorian.millisecondsSinceEpoch;
    } else {
      throw 'Cannot parse month number';
    }
  }

  int setFullYear(year, month, date) {
    if (year >= 1000 && year <= 9999) {
      _jalali['year'] = year;
      if (month != null) {
        if (month >= 0 && month <= 11) {
          _jalali['month'] = month;
        } else {
          throw 'Cannot parse month number';
        }
      }
      if (date != null) {
        if (date > 0 && date <= 31) {
          _jalali['date'] = date;
        } else {
          throw 'Cannot parse date number';
        }
      }
      var gd =
          jalaliToGregorian(_jalali['year'], _jalali['month'], _jalali['date']);
      _gregorian = DateTime(
          gd['year'],
          gd['month'],
          gd['date'],
          _gregorian.hour,
          _gregorian.minute,
          _gregorian.second,
          _gregorian.millisecond,
          _gregorian.microsecond);
      return _gregorian.millisecondsSinceEpoch;
    } else {
      throw 'Cannot parse year number';
    }
  }

  int setHours(hours, [min, sec, ms]) {
    if (hours != null && min != null && sec != null && ms != null) {
      _gregorian = DateTime(_gregorian.year, _gregorian.month, _gregorian.day,
          hours, min, sec, ms, _gregorian.microsecond);
    } else if (hours != null && min != null && sec != null) {
      _gregorian = DateTime(_gregorian.year, _gregorian.month, _gregorian.day,
          hours, min, sec, _gregorian.millisecond, _gregorian.microsecond);
    } else if (hours != null && min != null) {
      _gregorian = DateTime(
          _gregorian.year,
          _gregorian.month,
          _gregorian.day,
          hours,
          min,
          _gregorian.second,
          _gregorian.millisecond,
          _gregorian.microsecond);
    } else {
      _gregorian = DateTime(
          _gregorian.year,
          _gregorian.month,
          _gregorian.day,
          hours,
          _gregorian.minute,
          _gregorian.second,
          _gregorian.millisecond,
          _gregorian.microsecond);
    }
    return _gregorian.millisecondsSinceEpoch;
  }

  int setMilliseconds(ms) {
    _gregorian = DateTime(
        _gregorian.year,
        _gregorian.month,
        _gregorian.day,
        _gregorian.hour,
        _gregorian.minute,
        _gregorian.second,
        ms,
        _gregorian.microsecond);
    return _gregorian.millisecondsSinceEpoch;
  }

  int setMinutes(min, [sec, ms]) {
    if (min != null && sec != null && ms != null) {
      _gregorian = DateTime(_gregorian.year, _gregorian.month, _gregorian.day,
          _gregorian.hour, min, sec, ms, _gregorian.microsecond);
    } else if (min != null && sec != null) {
      _gregorian = DateTime(
          _gregorian.year,
          _gregorian.month,
          _gregorian.day,
          _gregorian.hour,
          min,
          sec,
          _gregorian.millisecond,
          _gregorian.microsecond);
    } else {
      _gregorian = DateTime(
          _gregorian.year,
          _gregorian.month,
          _gregorian.day,
          _gregorian.hour,
          min,
          _gregorian.second,
          _gregorian.millisecond,
          _gregorian.microsecond);
    }
    return _gregorian.millisecondsSinceEpoch;
  }

  int setSeconds(sec, [ms]) {
    if (sec != null && ms != null) {
      _gregorian = DateTime(_gregorian.year, _gregorian.month, _gregorian.day,
          _gregorian.hour, _gregorian.minute, sec, ms, _gregorian.microsecond);
    } else {
      _gregorian = DateTime(
          _gregorian.year,
          _gregorian.month,
          _gregorian.day,
          _gregorian.hour,
          _gregorian.minute,
          sec,
          _gregorian.millisecond,
          _gregorian.microsecond);
    }
    return _gregorian.millisecondsSinceEpoch;
  }

  int setTime(ms) {
    _gregorian = DateTime.fromMillisecondsSinceEpoch(ms);
    setJalali();
    return _gregorian.millisecondsSinceEpoch;
  }

  String echo([format = 'l، d F Y ساعت H:i:s']) {
    var leapYear = isLeapYear(),
        jw = getDay(),
        jy = getShortYear(),
        jtz = getTimezone();

    return format
        .replaceAll('a', (_gregorian.hour < 12) ? 'ق.ظ' : 'ب.ظ')
        .replaceAll('b', ((_jalali['month'] + 1) / 3.1).floor().toString())
        .replaceAll('d', withZero(_jalali['date']))
        .replaceAll(
            'f', jalaliSeasons[((_jalali['month'] + 1) / 3.1).floor()]['long'])
        .replaceAll(
            'g',
            _gregorian.hour <= 12
                ? _gregorian.hour.toString()
                : (_gregorian.hour - 12).toString())
        .replaceAll(
            'h',
            _gregorian.hour <= 12
                ? withZero(_gregorian.hour)
                : withZero(_gregorian.hour - 12))
        .replaceAll('i', withZero(_gregorian.minute))
        .replaceAll('j', _jalali['date'].toString())
        .replaceAll('l', jalaliWeeks[jw]['long'])
        .replaceAll('m', withZero(_jalali['month'] + 1))
        .replaceAll('n', (_jalali['month'] + 1).toString())
        .replaceAll('s', withZero(_gregorian.second))
        .replaceAll(
            't',
            ((_jalali['month'] + 1) != 12)
                ? (31 - ((_jalali['month'] + 1) / 6.5).floor()).toString()
                : (leapYear + 29).toString())
        .replaceAll('u', _gregorian.millisecond.toString())
        .replaceAll('v', jy.toPersianWords())
        .replaceAll('w', jw.toString())
        .replaceAll('y', jy.toString())
        .replaceAll('A', (_gregorian.hour < 12) ? 'قبل از ظهر' : 'بعد از ظهر')
        .replaceAll('D', jalaliWeeks[jw]['short'])
        .replaceAll('F', jalaliMonths[_jalali['month']]['long'])
        .replaceAll('G', _gregorian.hour.toString())
        .replaceAll('H', withZero(_gregorian.hour))
        .replaceAll('J', _jalali['date'].toPersianWords())
        .replaceAll('L', leapYear.toString())
        .replaceAll('M', jalaliMonths[_jalali['month']]['short'])
        .replaceAll('O', jtz)
        .replaceAll('V', _jalali['year'].toPersianWords())
        .replaceAll('Y', _jalali['year'].toString());
  }

  void setJalali() {
    _jalali =
        gregorianToJalali(_gregorian.year, _gregorian.month, _gregorian.day);
  }

  @override
  String toString() => echo();

//  parse(String string) {
//    string = trnumToEn(string);
//    var dateTime = Date.parse(string);
//    if (Number.isNaN(dateTime)) {
//      return NaN;
//    } else if (dateTime > 0) {
//      return dateTime;
//    } else {
//      var match =
//    /^(\d|\d\d|\d\d\d\d)(?:([-\/])(\d{1,2})(?:\2(\d|\d\d|\d\d\d\d))?)?(([ T])(\d{2}):(\d{2})(?::(\d{2})(?:\.(\d+))?)?(Z|([+-])(\d{2})(?::?(\d{2}))?)?)?$/.exec(string);
//    if (!match) return NaN;
//    var date = [];
//    date.separator = match[2];
//    date.delimiter = match[6];
//    date.year = +match[1];
//    date.month = +(match[3])-1 || 0;
//    date.date = +match[4] || 1;
//    date.hours = +match[7] || 0;
//    date.minutes = +match[8] || 0;
//    date.seconds = +match[9] || 0;
//    date.milliSeconds = +('0.' + (match[10] || '0')) * 1000;
//    date.isISO = ( separator != '/') && (match[6] != ' ');
//    date.timeZone = match[11];
//    date.isNonLocal =  isISO && ( timeZone || !match[5]);
//    date.timeZoneOffset = (match[12] == '-' ? -1 : 1) * ((+match[13] || 0) * 60 + (+match[14] || 0));
//
//    var gdt = jalali_to_gregorian(date.year, date.month, date.date);
//    var gd = new Date(gdt.year, gdt.month, gdt.date, date.hours, date.minutes, date.seconds, date.milliSeconds);
//    if (date.isNonLocal) {
//    gd.setUTCMinutes(gd.getUTCMinutes() - gd.getTimezoneOffset() + date.timeZoneOffset);
//    }
//    return gd.getTime();
//    }
  int now() => DateTime.now().millisecondsSinceEpoch;

  var jalaliMonths = [
    {'long': 'فروردین', 'short': 'فر'},
    {'long': 'اردیبهشت', 'short': 'ار'},
    {'long': 'خرداد', 'short': 'خر'},
    {'long': 'تیر', 'short': 'تی‍'},
    {'long': 'مرداد', 'short': 'مر'},
    {'long': 'شهریور', 'short': 'شه‍'},
    {'long': 'مهر', 'short': 'مه‍'},
    {'long': 'آبان', 'short': 'آب‍'},
    {'long': 'آذر', 'short': 'آذر'},
    {'long': 'دی', 'short': 'دی'},
    {'long': 'بهمن', 'short': 'به‍'},
    {'long': 'اسفند', 'short': 'اس‍'}
  ],
      jalaliSeasons = [
    {'long': 'بهار', 'short': 'به‍'},
    {'long': 'تابستان', 'short': 'تا'},
    {'long': 'پاییز', 'short': 'پا'},
    {'long': 'زمستان', 'short': 'زم‍'}
  ],
      jalaliWeeks = [
    {'long': 'شنبه', 'short': 'شن‍'},
    {'long': 'یکشنبه', 'short': 'یک'},
    {'long': 'دوشنبه', 'short': 'دو'},
    {'long': 'سه‌شنبه', 'short': 'سه'},
    {'long': 'چهارشنبه', 'short': 'چه‍'},
    {'long': 'پنج‌شنبه', 'short': 'پن‍'},
    {'long': 'جمعه', 'short': 'جم‍'}
  ];

  /// Jalali to Gregorian Conversion
  /// Copyright (C) 2000  Roozbeh Pournader and Mohammad Toossi
  static Map jalaliToGregorian(var jy, var jm, var jd) {
    jy = int.parse(jy.toString().numbersToEnglish()) - 979;
    jm = int.parse(jm.toString().numbersToEnglish()) - 1;
    jd = int.parse(jd.toString().numbersToEnglish()) - 1;
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

    return {'year': gy, 'month': gm, 'date': gd};
  }

  /// Gregorian to Jalali Conversion
  /// Copyright (C) 2000  Roozbeh Pournader and Mohammad Toossi
  static Map<String, int> gregorianToJalali(int gy, int gm, int gd) {
    gy = int.parse(gy.toString().numbersToEnglish()) - 1600;
    gm = int.parse(gm.toString().numbersToEnglish()) - 1;
    gd = int.parse(gd.toString().numbersToEnglish()) - 1;

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
    return {'year': jy, 'month': jm, 'date': jd};
  }

  String withZero(int num) =>
      (num < 10) ? '0' + num.toString() : num.toString();
}
