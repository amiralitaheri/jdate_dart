class JDate {
  Map jalali;
  DateTime gregorian;

  JDate([var year, var month, var date = 1, var hours = 0, var minutes = 0, var seconds = 0, var milliseconds = 0]) {
    gregorian = DateTime.now();
    if (year != null) {
      if (month == null) {
        if (year.toString().length <= 4) {
          year = year is int ? year : int.parse(year);
          gregorian = DateTime(year);
          if (gregorian.millisecondsSinceEpoch < 0) {
            var gd = jalaliToGregorian(year, 1, date);
            gregorian = DateTime(gd['year'], gd['month'], gd['date'], hours, minutes, seconds, milliseconds);
          }
        } else {
          gregorian = DateTime.tryParse(year.toString());
          if (gregorian?.millisecondsSinceEpoch == null || gregorian.millisecondsSinceEpoch < 0) {
//            gregorian = DateTime(parse(year));
            if (gregorian?.millisecondsSinceEpoch == null || gregorian.millisecondsSinceEpoch < 0) {
              throw 'Cannot parse date string';
            }
          }
        }
      } else {
        gregorian = DateTime(year, month, date);
        if (gregorian.millisecondsSinceEpoch < 0) {
          var gd = jalaliToGregorian(year, month, date);
          gregorian = DateTime(gd['year'], gd['month'], gd['date'], hours, minutes, seconds, milliseconds);
        }
      }
    }
    setJalali();
  }

  int getDate() {
    return jalali['date'];
  }

  int getDay() {
    return gregorian.weekday == 6 ? 0 : gregorian.weekday + 1;
  }

  int getFullYear() {
    return jalali['year'];
  }

  int getShortYear() {
    return (jalali['year'] >= 1300 && jalali['year'] < 1400)
        ? int.parse(jalali['year'].toString().substring(2))
        : int.parse(jalali['year'].toString().substring(1));
  }

  int getHour() {
    return gregorian.hour;
  }

  int getMilliseconds() {
    return gregorian.millisecond;
  }

  int getMinute() {
    return gregorian.minute;
  }

  int getMonth() {
    return jalali['month'];
  }

  int getSeconds() {
    return gregorian.second;
  }

  int getTime() {
    return gregorian.millisecondsSinceEpoch;
  }

  String getTimezone() {
    return gregorian.toString().cut('GMT', ' ');
  }

  int getTimezoneOffset() {
    return gregorian.timeZoneOffset.inMinutes;
  }

  int isLeapYear([var year]) {
    if (year == null) {
      return isLeapYear(jalali['year']);
    } else {
      year = (year is int) ? year : int.parse(year);
      return (year % 33 % 4 - 1 == (year % 33 * .05).floor()) ? 1 : 0;
    }
  }

  int setDate(date) {
    if (date > 0 && date <= 31) {
      jalali['date'] = date;
      var gd = jalaliToGregorian(jalali['year'], jalali['month'], jalali['date']);
      gregorian =
          DateTime(gd['year'], gd['month'], gd['date'], gregorian.hour, gregorian.minute, gregorian.second, gregorian.millisecond, gregorian.microsecond);
      return gregorian.millisecondsSinceEpoch;
    } else {
      throw 'Cannot parse date number';
    }
  }

  int setMonth(month, date) {
    if (month >= 0 && month <= 11) {
      jalali['month'] = month;
      if (date != null) {
        if (date > 0 && date <= 31) {
          jalali['date'] = date;
        } else {
          throw 'Cannot parse date number';
        }
      }
      var gd = jalaliToGregorian(jalali['year'], jalali['month'], jalali['date']);
      gregorian =
          DateTime(gd['year'], gd['month'], gd['date'], gregorian.hour, gregorian.minute, gregorian.second, gregorian.millisecond, gregorian.microsecond);
      return gregorian.millisecondsSinceEpoch;
    } else {
      throw 'Cannot parse month number';
    }
  }

  int setFullYear(year, month, date) {
    if (year >= 1000 && year <= 9999) {
      jalali['year'] = year;
      if (month != null) {
        if (month >= 0 && month <= 11) {
          jalali['month'] = month;
        } else {
          throw 'Cannot parse month number';
        }
      }
      if (date != null) {
        if (date > 0 && date <= 31) {
          jalali['date'] = date;
        } else {
          throw 'Cannot parse date number';
        }
      }
      var gd = jalaliToGregorian(jalali['year'], jalali['month'], jalali['date']);
      gregorian =
          DateTime(gd['year'], gd['month'], gd['date'], gregorian.hour, gregorian.minute, gregorian.second, gregorian.millisecond, gregorian.microsecond);
      return gregorian.millisecondsSinceEpoch;
    } else {
      throw 'Cannot parse year number';
    }
  }

  int setHours(hours, [min, sec, ms]) {
    if (hours != null && min != null && sec != null && ms != null) {
      gregorian = DateTime(gregorian.year, gregorian.month, gregorian.day, hours, min, sec, ms, gregorian.microsecond);
    } else if (hours != null && min != null && sec != null) {
      gregorian = DateTime(gregorian.year, gregorian.month, gregorian.day, hours, min, sec, gregorian.millisecond, gregorian.microsecond);
    } else if (hours != null && min != null) {
      gregorian = DateTime(gregorian.year, gregorian.month, gregorian.day, hours, min, gregorian.second, gregorian.millisecond, gregorian.microsecond);
    } else {
      gregorian =
          DateTime(gregorian.year, gregorian.month, gregorian.day, hours, gregorian.minute, gregorian.second, gregorian.millisecond, gregorian.microsecond);
    }
    return gregorian.millisecondsSinceEpoch;
  }

  int setMilliseconds(ms) {
    gregorian = DateTime(gregorian.year, gregorian.month, gregorian.day, gregorian.hour, gregorian.minute, gregorian.second, ms, gregorian.microsecond);
    return gregorian.millisecondsSinceEpoch;
  }

  int setMinutes(min, [sec, ms]) {
    if (min != null && sec != null && ms != null) {
      gregorian = DateTime(gregorian.year, gregorian.month, gregorian.day, gregorian.hour, min, sec, ms, gregorian.microsecond);
    } else if (min != null && sec != null) {
      gregorian = DateTime(gregorian.year, gregorian.month, gregorian.day, gregorian.hour, min, sec, gregorian.millisecond, gregorian.microsecond);
    } else {
      gregorian = DateTime(gregorian.year, gregorian.month, gregorian.day, gregorian.hour, min, gregorian.second, gregorian.millisecond, gregorian.microsecond);
    }
    return gregorian.millisecondsSinceEpoch;
  }

  int setSeconds(sec, [ms]) {
    if (sec != null && ms != null) {
      gregorian = DateTime(gregorian.year, gregorian.month, gregorian.day, gregorian.hour, gregorian.minute, sec, ms, gregorian.microsecond);
    } else {
      gregorian = DateTime(gregorian.year, gregorian.month, gregorian.day, gregorian.hour, gregorian.minute, sec, gregorian.millisecond, gregorian.microsecond);
    }
    return gregorian.millisecondsSinceEpoch;
  }

  int setTime(ms) {
    gregorian = DateTime.fromMillisecondsSinceEpoch(ms);
    setJalali();
    return gregorian.millisecondsSinceEpoch;
  }

  String echo([format = 'l، d F Y ساعت H:i:s']) {
    var leapYear = isLeapYear(), jw = getDay(), jy = getShortYear(), jtz = getTimezone();

    format = format.replace('a', (gregorian.hour < 12) ? 'ق.ظ' : 'ب.ظ');
    format = format.replace('b', (jalali['month'] + 1) / 3.1).floor();
    format = format.replace('d', withZiro(jalali['date']));
    format = format.replace('f', jalaliSeasons[((jalali['month'] + 1) / 3.1).floor()]['long']);
    format = format.replace('g', gregorian.hour <= 12 ? gregorian.hour : gregorian.hour - 12);
    format = format.replace('h', gregorian.hour <= 12 ? withZiro(gregorian.hour) : withZiro(gregorian.hour - 12));
    format = format.replace('i', withZiro(gregorian.minute));
    format = format.replace('j', jalali['date']);
    format = format.replace('l', jalaliWeeks[jw]['long']);
    format = format.replace('m', withZiro(jalali['month'] + 1));
    format = format.replace('n', jalali['month'] + 1);
    format = format.replace('s', withZiro(gregorian.second));
    format = format.replace('t', ((jalali['month'] + 1) != 12) ? (31 - ((jalali['month'] + 1) / 6.5).floor()) : (leapYear + 29));
    format = format.replace('u', gregorian.millisecond);
    format = format.replace('v', numToPersianStr(jy));
    format = format.replace('w', jw);
    format = format.replace('y', jy);

    format = format.replace('A', (gregorian.hour < 12) ? 'قبل از ظهر' : 'بعد از ظهر');
    format = format.replace('D', jalaliWeeks[jw]['short']);
    format = format.replace('F', jalaliMonths[jalali['month']]['long']);
    format = format.replace('G', gregorian.hour);
    format = format.replace('H', withZiro(gregorian.hour));
    format = format.replace('J', numToPersianStr(jalali['date']));
    format = format.replace('L', leapYear);
    format = format.replace('M', jalaliMonths[jalali['month']]['short']);
    format = format.replace('O', jtz);

    format = format.replace('V', numToPersianStr(jalali['year']));
    format = format.replace('Y', jalali['year']);

    return format;
  }

  void setJalali() {
    jalali = gregorianToJalali(gregorian.year, gregorian.month, gregorian.day);
  }

  @override
  String toString() {
    return echo();
  }

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
  ],
      jalaliTRWeek = {0: 1, 1: 2, 2: 3, 3: 4, 4: 5, 5: 6, 6: 0};

  Map jalaliToGregorian(var jy, var jm, var jd) {
    jy = int.parse(trnumToEn(jy));
    jm = int.parse(trnumToEn(jm)) + 1;
    jd = int.parse(trnumToEn(jd));
    var gy = (jy <= 979) ? 621 : 1600;
    jy -= (jy <= 979) ? 0 : 979;
    var days = (365 * jy) + ((jy / 33).floor() * 8) + (((jy % 33) + 3) / 4).floor() + 78 + jd + ((jm < 7) ? (jm - 1) * 31 : ((jm - 7) * 30) + 186);
    gy += 400 * (days / 146097).floor();
    days %= 146097;

    if (days > 36524) {
      gy += 100 * (--days / 36524).floor();
      days %= 36524;
      if (days >= 365) days++;
    }
    gy += 4 * ((days) / 1461).floor();
    days %= 1461;
    gy += ((days - 1) / 365).floor();
    if (days > 365) days = (days - 1) % 365;
    var gd = days + 1;
    var months = [0, 31, ((gy % 4 == 0 && gy % 100 != 0) || (gy % 400 == 0)) ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    var i = 0;
    for (i; i < months.length; i++) {
      if (gd <= months[i]) break;
      gd -= months[i];
    }
    var gm = i - 1;

    return {'year': gy, 'month': gm, 'date': gd};
  }

  /// Gregorian to Jalali Conversion
  /// Copyright (C) 2000  Roozbeh Pournader and Mohammad Toossi
  Map gregorianToJalali(var gy, var gm, var gd) {
    gy = int.parse(trnumToEn(gy)) - 1600;
    gm = int.parse(trnumToEn(gm)) - 1;
    gd = int.parse(trnumToEn(gd)) - 1;

    var gDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    var jDaysInMonth = [31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29];

    var gDayNo = 365 * gy + ((gy + 3) / 4).floor() - ((gy + 99) / 100).floor() + ((gy + 399) / 400).floor();

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

  String numToPersianStr(var number, [counter = false]) {
    number = (number is String) ? int.parse(number) : number;
    var yekan = ['صفر', 'یک', 'دو', 'سه', 'چهار', 'پنج', 'شش', 'هفت', 'هشت', 'نه'],
        dahgan = ['', '', 'بیست', 'سی', 'چهل', 'پنجاه', 'شصت', 'هفتاد', 'هشتاد', 'نود'],
        dahyek = ['ده', 'یازده', 'دوازده', 'سیزده', 'چهارده', 'پانزده', 'شانزده', 'هفده', 'هجده', 'نوزده'],
        sadgan = ['', 'یکصد', 'دویست', 'سیصد', 'چهارصد', 'پانصد', 'ششصد', 'هفتصد', 'هشتصد', 'نهصد'],
        basegan = ['', 'هزار', 'میلیون', 'میلیارد', 'تریلیون'];

    var stotal = '';

    if (number == 0) return 'صفر';
    if (number.toString().length <= 3) {
      var stotal = '', d12 = number % 100, d3 = number / 100;

      if (d3 != 0) {
        stotal = sadgan[d3] + ' و ';
      }

      if ((d12 >= 10) && (d12 <= 19)) {
        stotal = stotal + dahyek[d12 - 10];
      } else {
        var d2 = d12 / 10;
        if (d2 != 0) {
          stotal = stotal + dahgan[d2] + ' و ';
        }

        var d1 = d12 % 10;
        if (d1 != 0) {
          stotal = stotal + yekan[d1] + ' و ';
        }

        stotal = stotal.substring(0, stotal.length - 3);
      }
    } else {
      var pad = chunkArray(number.toString().split(''), 3);
      var padLen = pad[pad.length - 1].length;
      switch (padLen) {
        case 1:
          padLen = 2;
          break;
        case 2:
          padLen = 1;
          break;
        default:
          padLen = 0;
      }
      number = number.toString().padLeft(number.toString().length + padLen, '0');
      var L = (number.toString().length / 3 - 1).floor(), b;
      for (var i = 0; i <= L; i++) {
        b = int.parse(number.toString().substring(i * 3, 3));
        if (b != 0) {
          stotal = stotal + numToPersianStr(b) + ' ' + basegan[L - i] + ' و ';
        }
      }
      stotal = stotal.substring(0, -4);
    }

    stotal = stotal.trim();

    if (!counter) {
      return stotal;
    } else {
      if (number == 1) {
        return 'اول';
      } else if (number.toString().substring(-1) == 3 && number.toString().substring(-2) != 'ده') {
        return stotal.toString().substring(0, -1) + 'وم';
      } else if (number.toString().substring(-2) == 30) {
        return stotal + ' ام';
      } else {
        return stotal + 'م';
      }
    }
  }

  List chunkArray(List myArray, int chunk_size) {
    var tempArray = [];

    for (var index = 0; index < myArray.length; index += chunk_size) {
      tempArray.add(myArray.sublist(index, index + chunk_size));
    }

    return tempArray;
  }

  String trnumToFa(number) {
    return number
        .toString()
        .replaceAll('0', '۰')
        .replaceAll('1', '۱')
        .replaceAll('2', '۲')
        .replaceAll('3', '۳')
        .replaceAll('4', '۴')
        .replaceAll('5', '۵')
        .replaceAll('6', '۶')
        .replaceAll('7', '۷')
        .replaceAll('8', '۸')
        .replaceAll('9', '۹');
  }

  String trnumToEn(var number) {
    return number
        .toString()
        .replaceAll('[۰٠]', '0')
        .replaceAll(RegExp(r'[۱١]'), '1')
        .replaceAll(RegExp(r'[۲٢]'), '2')
        .replaceAll(RegExp(r'[۳٣]'), '3')
        .replaceAll(RegExp(r'[۴٤]'), '4')
        .replaceAll(RegExp(r'[۵٥]'), '5')
        .replaceAll(RegExp(r'[۶٦]'), '6')
        .replaceAll(RegExp(r'[۷٧]'), '7')
        .replaceAll(RegExp(r'[۸٨]'), '8')
        .replaceAll(RegExp(r'[۹٩]'), '9');
  }

  String withZiro(int num) => (num < 10) ? '0' + num.toString() : num.toString();
}

extension NumberParsing on String {
  String cut(String left, String right, [bool withBoth = false]) {
    var str = substring(toLowerCase().indexOf(left.toString().toLowerCase())).substring(left.toString().length);
    var leftLen = str.substring(str.toLowerCase().indexOf(right.toString().toLowerCase())).toString().length;
    leftLen = (leftLen != 0) ? -(leftLen) : str.toString().length;
    str = str.substring(0, leftLen);

    if (withBoth) {
      str = left + str + right;
    }

    return str;
  }
}
