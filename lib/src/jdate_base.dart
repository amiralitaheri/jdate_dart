import 'basic_date.dart';
import 'consts.dart';
import 'converters.dart' as converter;
import 'extensions/number_extensions.dart';
import 'extensions/string_extensions.dart';
import 'js/is_js.dart' if (dart.library.io) 'vm/is_js.dart';

class JDate implements Comparable<JDate> {
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
  int _weekday;
  bool _isUtc;

  /// The number of microseconds since
  /// the 'Unix epoch' 1970-01-01T00:00:00Z (UTC).
  ///
  /// This value is independent of the time zone.
  ///
  /// This value is at most
  /// 8,640,000,000,000,000,000us (100,000,000 days) from the Unix epoch.
  /// In other words: `microsecondsSinceEpoch.abs() <= 8640000000000000000`.
  ///
  /// Note that this value does not fit into 53 bits (the size of a IEEE double).
  /// A JavaScript number is not able to hold this value.
  int get microsecondsSinceEpoch => _microsecondsSinceEpoch;

  /// The number of microseconds since
  /// the 'Unix epoch' 1970-01-01T00:00:00Z (UTC).
  ///
  /// This value is independent of the time zone.
  ///
  /// This value is at most
  /// 8,640,000,000,000,000,000us (100,000,000 days) from the Unix epoch.
  /// In other words: `microsecondsSinceEpoch.abs() <= 8640000000000000000`.
  ///
  /// Note that this value does not fit into 53 bits (the size of a IEEE double).
  /// A JavaScript number is not able to hold this value.
  set microsecondsSinceEpoch(int microsecondsSinceEpoch) {
    if (microsecondsSinceEpoch.abs() <= 8640000000000000000) {
      _internal(DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch));
    }
  }

  /// The number of milliseconds since
  /// the 'Unix epoch' 1970-01-01T00:00:00Z (UTC).
  ///
  /// This value is independent of the time zone.
  ///
  /// This value is at most
  /// 8,640,000,000,000,000ms (100,000,000 days) from the Unix epoch.
  /// In other words: `millisecondsSinceEpoch.abs() <= 8640000000000000`.
  int get millisecondsSinceEpoch => _millisecondsSinceEpoch;

  /// The number of milliseconds since
  /// the 'Unix epoch' 1970-01-01T00:00:00Z (UTC).
  ///
  /// This value is independent of the time zone.
  ///
  /// This value is at most
  /// 8,640,000,000,000,000ms (100,000,000 days) from the Unix epoch.
  /// In other words: `millisecondsSinceEpoch.abs() <= 8640000000000000`.
  set millisecondsSinceEpoch(int millisecondsSinceEpoch) {
    if (millisecondsSinceEpoch.abs() <= 8640000000000000) {
      _internal(DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch));
    }
  }

  /// The microsecond [0...999].
  ///
  /// ```
  /// var moonLanding = JDate.parse('1969-07-20 20:18:04Z');
  /// assert(moonLanding.microsecond == 0);
  /// ```
  int get microsecond => _microsecond;

  /// The microsecond [0...999].
  ///
  /// ```
  /// var moonLanding = JDate.parse('1969-07-20 20:18:04Z');
  /// assert(moonLanding.microsecond == 0);
  /// ```
  set microsecond(int microsecond) {
    if (microsecond >= 0 && microsecond < 1000) {
      _microsecondsSinceEpoch += -_microsecond + microsecond;
      _microsecond = microsecond;
    } else {
      throw 'Microsecond number out of range';
    }
  }

  /// The millisecond [0...999].
  ///
  /// ```
  /// var moonLanding = JDate.parse('1969-07-20 20:18:04Z');
  /// assert(moonLanding.millisecond == 0);
  /// ```
  int get millisecond => _millisecond;

  /// The millisecond [0...999].
  ///
  /// ```
  /// var moonLanding = JDate.parse('1969-07-20 20:18:04Z');
  /// assert(moonLanding.millisecond == 0);
  /// ```
  set millisecond(int millisecond) {
    if (millisecond >= 0 && millisecond < 1000) {
      _microsecondsSinceEpoch += 1000 * (-_millisecond + millisecond);
      _millisecondsSinceEpoch += -_millisecond + millisecond;
      _millisecond = millisecond;
    } else {
      throw 'Millisecond number out of range';
    }
  }

  /// The second [0...59].
  ///
  /// ```
  /// var moonLanding = Jdate.parse('1969-07-20 20:18:04Z');
  /// assert(moonLanding.second == 4);
  /// ```
  int get second => _second;

  /// The second [0...59].
  ///
  /// ```
  /// var moonLanding = Jdate.parse('1969-07-20 20:18:04Z');
  /// assert(moonLanding.second == 4);
  /// ```
  set second(int second) {
    if (second >= 0 && second < 60) {
      _microsecondsSinceEpoch += 1000000 * (-_second + second);
      _millisecondsSinceEpoch += 1000 * (-_second + second);
      _second = second;
    } else {
      throw 'Second number out of range';
    }
  }

  /// The minute [0...59].
  ///
  /// ```
  /// var moonLanding = JDate.parse('1969-07-20 20:18:04Z');
  /// assert(moonLanding.minute == 18);
  /// ```
  int get minute => _minute;

  /// The minute [0...59].
  ///
  /// ```
  /// var moonLanding = JDate.parse('1969-07-20 20:18:04Z');
  /// assert(moonLanding.minute == 18);
  /// ```
  set minute(int minute) {
    if (minute >= 0 && minute < 60) {
      _microsecondsSinceEpoch += 60 * 1000000 * (-_minute + minute);
      _millisecondsSinceEpoch += 60 * 1000 * (-_minute + minute);
      _minute = minute;
    } else {
      throw 'Minute number out of range';
    }
  }

  /// The hour of the day, expressed as in a 24-hour clock [0..23].
  ///
  /// ```
  /// var moonLanding = JDate.parse('1969-07-20 20:18:04Z');
  /// assert(moonLanding.hour == 20);
  /// ```
  int get hour => _hour;

  /// The hour of the day, expressed as in a 24-hour clock [0..23].
  ///
  /// ```
  /// var moonLanding = JDate.parse('1969-07-20 20:18:04Z');
  /// assert(moonLanding.hour == 20);
  /// ```
  set hour(int hour) {
    if (hour >= 0 && hour < 60) {
      _microsecondsSinceEpoch += 60 * 60 * 1000000 * (-_hour + hour);
      _millisecondsSinceEpoch += 60 * 60 * 1000 * (-_hour + hour);
      _hour = hour;
    } else {
      throw 'Hour number out of range';
    }
  }

  /// The day of the month [1..31].
  ///
  /// ```
  /// var moonLanding = DateTime.parse('1969-07-20 20:18:04Z').toJDate();
  /// assert(moonLanding.day == 29);
  /// ```
  int get day => _day;

  /// The day of the month [1..31].
  ///
  /// ```
  /// var moonLanding = DateTime.parse('1969-07-20 20:18:04Z').toJDate();
  /// assert(moonLanding.day == 29);
  /// ```
  set day(int day) {
    if (day > 0 && day <= monthLength) {
      _day = day;
      final date = converter.jalaliToGregorian(_year, _month, _day);
      final gregorian = DateTime(
        date.year,
        date.month,
        date.day,
        _hour,
        _minute,
        _second,
        _millisecond,
        _microsecond,
      );
      _millisecondsSinceEpoch = gregorian.millisecondsSinceEpoch;
      _microsecondsSinceEpoch = gregorian.microsecondsSinceEpoch;
      _weekday = (gregorian.weekday + 1) % 7;
    } else {
      throw 'Day number out of range';
    }
  }

  /// The month [1..12].
  ///
  /// ```
  /// var moonLanding = DateTime.parse('1969-07-20 20:18:04Z').toJDate();
  /// assert(moonLanding.month == 4);
  /// ```
  int get month => _month;

  /// The month [1..12].
  ///
  /// ```
  /// var moonLanding = DateTime.parse('1969-07-20 20:18:04Z').toJDate();
  /// assert(moonLanding.month == 4);
  /// ```
  set month(int month) {
    if (month > 0 && month <= 12) {
      _month = month;
      final date = converter.jalaliToGregorian(_year, _month, _day);
      final gregorian = DateTime(
        date.year,
        date.month,
        date.day,
        _hour,
        _minute,
        _second,
        _millisecond,
        _microsecond,
      );
      _millisecondsSinceEpoch = gregorian.millisecondsSinceEpoch;
      _microsecondsSinceEpoch = gregorian.microsecondsSinceEpoch;
      _weekday = (gregorian.weekday + 1) % 7;
    } else {
      throw 'Month number out of range';
    }
  }

  /// The year.
  ///
  /// ```
  /// var moonLanding = DateTime.parse('1969-07-20 20:18:04Z').toJDate();
  /// assert(moonLanding.year == 1348);
  /// ```
  int get year => _year;

  /// The year.
  ///
  /// ```
  /// var moonLanding = DateTime.parse('1969-07-20 20:18:04Z').toJDate();
  /// assert(moonLanding.year == 1348);
  /// ```
  set year(int year) {
    if (year > 0) {
      _year = year;
      final date = converter.jalaliToGregorian(_year, _month, _day);
      final gregorian = DateTime(
        date.year,
        date.month,
        date.day,
        _hour,
        _minute,
        _second,
        _millisecond,
        _microsecond,
      );
      _millisecondsSinceEpoch = gregorian.millisecondsSinceEpoch;
      _microsecondsSinceEpoch = gregorian.microsecondsSinceEpoch;
      _weekday = (gregorian.weekday + 1) % 7;
    } else {
      throw 'Year number out of range';
    }
  }

  /// The day of the week شنبه..جمعه.
  ///
  /// a week starts with شنبه, which has the value 1.
  ///
  /// ```
  /// var moonLanding = DateTime.parse('1969-07-20 20:18:04Z').toJDate();
  /// assert(moonLanding.weekday == 2);
  /// ```
  int get weekday => _weekday + 1;

  /// The time zone offset, which
  /// is the difference between local time and UTC.
  ///
  /// The offset is positive for time zones east of UTC.
  ///
  /// Note, that JavaScript, Python and C return the difference between UTC and
  /// local time. Java, C# and Ruby return the difference between local time and
  /// UTC.
  Duration get timeZoneOffset => _timeZoneOffset;

  /// The time zone name.
  ///
  /// This value is provided by the operating system and may be an
  /// abbreviation or a full name.
  ///
  /// In the browser or on Unix-like systems commonly returns abbreviations,
  /// such as 'CET' or 'CEST'. On Windows returns the full name, for example
  /// 'Pacific Standard Time'.
  String get timeZoneName => _timeZoneName;

  /// True if this [JDate] is set to UTC time.
  ///
  /// ```
  /// var date = JDate.utc(1377, 6, 6);
  /// assert(date.isUtc);
  /// ```
  ///
  bool get isUtc => _isUtc;

  /// Returns the name of weekDay in persian.
  /// ```
  /// var moonLanding = DateTime.parse('1969-07-20 20:18:04Z').toJDate();
  /// assert(moonLanding.weekDayName == 'یکشنبه');
  /// ```
  String get weekdayName => jalaliDays[_weekday]['long'];

  /// Returns the name of month in persian.
  /// ```
  /// var moonLanding = DateTime.parse('1969-07-20 20:18:04Z').toJDate();
  /// assert(moonLanding.weekDayName == 'مرداد');
  /// ```
  String get monthName => jalaliMonths[month]['long'];

  /// True if this [JDate.year] is a leap year.
  /// ```
  /// var moonLanding = DateTime.parse('1969-07-20 20:18:04Z').toJDate();
  /// assert(moonLanding.isLeapYear == false);
  /// ```
  bool get isLeapYear => _isLeapYear(_year);

  /// Returns the short version of year.
  int get shortYear {
    //todo: ask someone
    if (_year >= 1300 && _year < 1400) {
      return int.parse(_year.toString().substring(2)); //1375 -> 75
    } else {
      return _year; //85 -> 85, 1000 -> 1000
    }
  }

  /// Returns number of days in that month.
  ///
  /// ```Dart
  /// var monthDays = JDate.now().getMonthLength();
  /// ```
  int get monthLength => _getMonthLength(_year, _month);

  /// Constructs a [JDate] instance specified in the local time zone.
  ///
  /// For example,
  /// to create a new JDate object representing the 5th of Khordad 1377,
  /// 5:30pm
  ///
  /// ```
  /// var dentistAppointment = JDate(1377, 3, 7, 17, 30);
  /// ```
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
    final greg = jalaliToGregorian(year, month, day);
    final datetime = DateTime(
      greg.year,
      greg.month,
      greg.day,
      hour ?? _hour,
      minute ?? _minute,
      second ?? _second,
      millisecond ?? _millisecond,
      microsecond ?? _microsecond,
    );

    _internal(datetime);
  }

  /// Constructs a [JDate] instance specified in the UTC time zone.
  ///
  /// ```
  /// var moonLanding = JDate.utc(1377, 7, 20, 20, 18, 04);
  /// ```
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
    final greg = jalaliToGregorian(year, month, day);
    final datetime = DateTime.utc(
      greg.year,
      greg.month,
      greg.day,
      hour ?? _hour,
      minute ?? _minute,
      second ?? _second,
      millisecond ?? _millisecond,
      microsecond ?? _microsecond,
    );

    _internal(datetime);
  }

  /// Constructs a [JDate] instance from given [DateTime].
  ///
  /// ```
  /// var date = DateTime(1977, 5, 12);
  /// var jDate = JDate.fromDateTime(date);
  /// ```
  JDate.fromDateTime(DateTime date) {
    _internal(date);
  }

  /// Constructs a new [JDate] instance
  /// with the given [microsecondsSinceEpoch].
  ///
  /// If [isUtc] is false then the date is in the local time zone.
  ///
  /// The constructed [JDate] represents
  /// 1348-10-11 00:00:00 + [microsecondsSinceEpoch] ms in the given
  /// time zone (local or UTC).
  ///
  /// [microsecondsSinceEpoch] is completely based on gregorian.
  JDate.fromMicrosecondsSinceEpoch(int microsecondsSinceEpoch,
      {bool isUtc = false}) {
    _internal(DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch,
        isUtc: isUtc));
  }

  /// Constructs a new [JDate] instance
  /// with the given [millisecondsSinceEpoch].
  ///
  /// If [isUtc] is false then the date is in the local time zone.
  ///
  /// The constructed [JDate] represents
  /// 1348-10-11 00:00:00 + [millisecondsSinceEpoch] ms in the given
  /// time zone (local or UTC).
  ///
  /// [millisecondsSinceEpoch] is completely based on gregorian.
  JDate.fromMillisecondsSinceEpoch(int millisecondsSinceEpoch,
      {bool isUtc = false}) {
    _internal(DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch,
        isUtc: isUtc));
  }

  /// Constructs a [JDate] instance with current date and time in the
  /// local time zone.
  ///
  /// ```
  /// var thisInstant = new JDate.now();
  /// ```
  JDate.now() : this.fromDateTime(DateTime.now());

  static String _fourDigits(int n) {
    final absN = n.abs();
    final sign = n < 0 ? '-' : '';
    if (absN >= 1000) return '$n';
    if (absN >= 100) return '${sign}0$absN';
    if (absN >= 10) return '${sign}00$absN';
    return '${sign}000$absN';
  }

  static String _sixDigits(int n) {
    assert(n < -9999 || n > 9999);
    final absN = n.abs();
    final sign = n < 0 ? '-' : '+';
    if (absN >= 100000) return '$sign$absN';
    return '${sign}0$absN';
  }

  static String _threeDigits(int n) {
    if (n >= 100) return '${n}';
    if (n >= 10) return '0${n}';
    return '00${n}';
  }

  static String _twoDigits(int n) {
    if (n >= 10) return '${n}';
    return '0${n}';
  }

  bool _isLeapYear(year) => year % 33 % 4 - 1 == (year % 33 * .05).floor();

  // Main function that set everything in object
  void _internal(DateTime dateTime) {
    //initialize parameters
    final greg = gregorianToJalali(dateTime.year, dateTime.month, dateTime.day);
    _year = greg.year;
    _month = greg.month;
    _day = greg.day;
    _hour = dateTime.hour;
    _minute = dateTime.minute;
    _second = dateTime.second;
    _millisecond = dateTime.millisecond;
    _microsecond = dateTime.microsecond;
    _isUtc = dateTime.isUtc;
    _timeZoneName = dateTime.timeZoneName;
    _timeZoneOffset = dateTime.timeZoneOffset;
    _weekday = (dateTime.weekday + 1) % 7;
    _millisecondsSinceEpoch = dateTime.millisecondsSinceEpoch;
    _microsecondsSinceEpoch = dateTime.microsecondsSinceEpoch;
  }

  int _getMonthLength(int year, int month) {
    if (month <= 6) {
      return 31;
    } else if (month == 12) {
      return _isLeapYear(year) ? 30 : 29;
    } else {
      return 30;
    }
  }

  /// Parse the string an returns a JDate object, throws Exception if string is not valid.
  static JDate parse(String string) {
    string = string.numbersToEnglish().replaceAll(RegExp(r'[/\\]'), '-');
    final date = DateTime.parse(string);

    if (date.isUtc) {
      return JDate.utc(
        date.year,
        date.month,
        date.day,
        date.hour,
        date.minute,
        date.second,
        date.millisecond,
        date.microsecond,
      );
    } else {
      return JDate(
        date.year,
        date.month,
        date.day,
        date.hour,
        date.minute,
        date.second,
        date.millisecond,
        date.microsecond,
      );
    }
  }

  /// Tries to parse the string an returns a JDate object, returns null if string is not valid.
  static JDate tryParse(String string) {
    string = string.numbersToEnglish().replaceAll(RegExp(r'[/\\]'), '-');
    final date = DateTime.tryParse(string);
    if (date == null) return null;
    if (date.isUtc) {
      return JDate.utc(
        date.year,
        date.month,
        date.day,
        date.hour,
        date.minute,
        date.second,
        date.millisecond,
        date.microsecond,
      );
    } else {
      return JDate(
        date.year,
        date.month,
        date.day,
        date.hour,
        date.minute,
        date.second,
        date.millisecond,
        date.microsecond,
      );
    }
  }

  /// Change a [JDate] instance to specified parameters.
  /// returns currently changed [JDate]
  ///
  /// ```
  /// var specifiedDate = JDate.now().changeTo(month: 10, day: 1);
  /// ```
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
    final greg = jalaliToGregorian(year ?? _year, month ?? _month, day ?? _day);
    var datetime;
    if (isUtc ?? _isUtc) {
      datetime = DateTime.utc(
        greg.year,
        greg.month,
        greg.day,
        hour ?? _hour,
        minute ?? _minute,
        second ?? _second,
        millisecond ?? _millisecond,
        microsecond ?? _microsecond,
      );
    } else {
      datetime = DateTime(
        greg.year,
        greg.month,
        greg.day,
        hour ?? _hour,
        minute ?? _minute,
        second ?? _second,
        millisecond ?? _millisecond,
        microsecond ?? _microsecond,
      );
    }
    _internal(datetime);
    return this;
  }

  /// Turns [JDate] to [String] base on format.
  String echo([String format = 'l، d F Y ساعت H:i:s']) {
    final leapYear = isLeapYear;
    final jw = _weekday;
    final jy = shortYear;
    final jtz = _timeZoneName;

    return format
        .replaceAll('a', (_hour < 12) ? 'ق.ظ' : 'ب.ظ')
        .replaceAll('b', ((_month) / 3.1).floor().toString())
        .replaceAll('d', _twoDigits(_day))
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
          _hour <= 12 ? _twoDigits(_hour) : _twoDigits(_hour - 12),
        )
        .replaceAll('i', _twoDigits(_minute))
        .replaceAll('j', _day.toString())
        .replaceAll('l', jalaliDays[jw]['long'])
        .replaceAll('m', _twoDigits(_month))
        .replaceAll('n', (_month + 1).toString())
        .replaceAll('s', _twoDigits(_second))
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
        .replaceAll('D', jalaliDays[jw]['short'])
        .replaceAll('F', jalaliMonths[_month - 1]['long'])
        .replaceAll('G', _hour.toString())
        .replaceAll('H', _twoDigits(_hour))
        .replaceAll('J', _day.toPersianWords())
        .replaceAll('L', leapYear.toString())
        .replaceAll('M', jalaliMonths[_month - 1]['short'])
        .replaceAll('O', jtz)
        .replaceAll('V', _year.toPersianWords())
        .replaceAll('Y', _year.toString());
  }

  /// Returns a human-readable string for this instance.
  ///
  /// The returned string is constructed for the time zone of this instance.
  /// The `toString()` method provides a simply formatted string.
  ///
  /// The resulting string can be parsed back using [parse],
  @override
  String toString(){
    var y = _fourDigits(year);
    var m = _twoDigits(month);
    var d = _twoDigits(day);
    var h = _twoDigits(hour);
    var min = _twoDigits(minute);
    var sec = _twoDigits(second);
    var ms = _threeDigits(millisecond);
    var us = microsecond == 0 ? '' : _threeDigits(microsecond);
    if (isUtc) {
      return '$y-$m-$d $h:$min:$sec.$ms${us}Z';
    } else {
      return '$y-$m-$d $h:$min:$sec.$ms$us';
    }
  }

  /// Converts this [JDate] to a DateTime object with gregorian date.
  DateTime toDateTime() => isJs
      ? DateTime.fromMillisecondsSinceEpoch(_millisecondsSinceEpoch)
      : DateTime.fromMicrosecondsSinceEpoch(_microsecondsSinceEpoch);

  /// Returns a new [JDate] instance with [duration] added to [this].
  ///
  /// ```
  /// var today = new JDate.now();
  /// var fiftyDaysFromNow = today.add(new Duration(days: 50));
  /// ```
  ///
  /// Notice that the duration being added is actually 50 * 24 * 60 * 60
  /// seconds. If the resulting `JDate` has a different daylight saving offset
  /// than `this`, then the result won't have the same time-of-day as `this`, and
  /// may not even hit the calendar date 50 days later.
  ///
  /// Be careful when working with dates in local time.
  JDate add(Duration duration) => isJs
      ? JDate.fromMillisecondsSinceEpoch(
          _millisecondsSinceEpoch + duration.inMilliseconds)
      : JDate.fromMicrosecondsSinceEpoch(
          _microsecondsSinceEpoch + duration.inMicroseconds);

  /// Returns a new [JDate] instance with [duration] subtracted from [this].
  ///
  /// ```
  /// JDate today = new JDate.now();
  /// JDate fiftyDaysAgo = today.subtract(new Duration(days: 50));
  /// ```
  ///
  /// Notice that the duration being subtracted is actually 50 * 24 * 60 * 60
  /// seconds. If the resulting `JDate` has a different daylight saving offset
  /// than `this`, then the result won't have the same time-of-day as `this`, and
  /// may not even hit the calendar date 50 days earlier.
  ///
  /// Be careful when working with dates in local time.
  JDate subtract(Duration duration) => isJs
      ? JDate.fromMillisecondsSinceEpoch(
          _millisecondsSinceEpoch - duration.inMilliseconds)
      : JDate.fromMicrosecondsSinceEpoch(
          _microsecondsSinceEpoch - duration.inMicroseconds);

  /// Returns true if [other] is a [JDate] at the same moment and in the
  /// same time zone (UTC or local).
  ///
  /// ```
  /// var dDayUtc = new JDate.utc(1944, 6, 6);
  /// var dDayLocal = dDayUtc.toLocal();
  ///
  /// // These two dates are at the same moment, but are in different zones.
  /// assert(dDayUtc != dDayLocal);
  /// ```
  ///
  /// See [isAtSameMomentAs] for a comparison that compares moments in time
  /// independently of their zones.
  @override
  bool operator ==(dynamic other) =>
      (other is JDate && _timeZoneOffset == other.timeZoneOffset)
          ? isJs
              ? (_millisecondsSinceEpoch == other.millisecondsSinceEpoch)
              : (_microsecondsSinceEpoch == other.microsecondsSinceEpoch)
          : false;

  /// Returns true if [this] occurs at the same moment as [other].
  ///
  /// The comparison is independent of whether the time is in UTC or in the local
  /// time zone.
  ///
  /// ```
  /// var now = new JDate.now();
  /// var later = now.add(const Duration(seconds: 5));
  /// assert(!later.isAtSameMomentAs(now));
  /// assert(now.isAtSameMomentAs(now));
  ///
  /// // This relation stays the same, even when changing timezones.
  /// assert(!later.isAtSameMomentAs(now.toUtc()));
  /// assert(!later.toUtc().isAtSameMomentAs(now));
  ///
  /// assert(now.toUtc().isAtSameMomentAs(now));
  /// assert(now.isAtSameMomentAs(now.toUtc()));
  /// ```
  bool isAtSameMomentAs(JDate other) =>
      toDateTime().isAtSameMomentAs(other.toDateTime());

  /// Returns true if [this] occurs before [other].
  ///
  /// The comparison is independent
  /// of whether the time is in UTC or in the local time zone.
  ///
  /// ```
  /// var now = new JDate.now();
  /// var earlier = now.subtract(const Duration(seconds: 5));
  /// assert(earlier.isBefore(now));
  /// assert(!now.isBefore(now));
  ///
  /// // This relation stays the same, even when changing timezones.
  /// assert(earlier.isBefore(now.toUtc()));
  /// assert(earlier.toUtc().isBefore(now));
  ///
  /// assert(!now.toUtc().isBefore(now));
  /// assert(!now.isBefore(now.toUtc()));
  /// ```
  bool isBefore(JDate other) => toDateTime().isBefore(other.toDateTime());

  /// Returns true if [this] occurs after [other].
  ///
  /// The comparison is independent
  /// of whether the time is in UTC or in the local time zone.
  ///
  /// ```
  /// var now = new JDate.now();
  /// var later = now.add(const Duration(seconds: 5));
  /// assert(later.isAfter(now));
  /// assert(!now.isBefore(now));
  ///
  /// // This relation stays the same, even when changing timezones.
  /// assert(later.isAfter(now.toUtc()));
  /// assert(later.toUtc().isAfter(now));
  ///
  /// assert(!now.toUtc().isBefore(now));
  /// assert(!now.isBefore(now.toUtc()));
  /// ```
  bool isAfter(JDate other) => toDateTime().isAfter(other.toDateTime());

  /// Returns a [Duration] with the difference when subtracting [other] from
  /// [this].
  ///
  /// The returned [Duration] will be negative if [other] occurs after [this].
  ///
  /// ```
  /// var berlinWallFell = new DateTime.utc(1989, DateTime.november, 9);
  /// var dDay = new DateTime.utc(1944, DateTime.june, 6);
  ///
  /// Duration difference = berlinWallFell.difference(dDay);
  /// assert(difference.inDays == 16592);
  /// ```
  ///
  /// The difference is measured in seconds and fractions of seconds.
  /// The difference above counts the number of fractional seconds between
  /// midnight at the beginning of those dates.
  /// If the dates above had been in local time, not UTC, then the difference
  /// between two midnights may not be a multiple of 24 hours due to daylight
  /// saving differences.
  ///
  /// For example, in Australia, similar code using local time instead of UTC:
  ///
  /// ```
  /// var berlinWallFell = new DateTime(1989, DateTime.november, 9);
  /// var dDay = new DateTime(1944, DateTime.june, 6);
  /// Duration difference = berlinWallFell.difference(dDay);
  /// assert(difference.inDays == 16592);
  /// ```
  /// will fail because the difference is actually 16591 days and 23 hours, and
  /// [Duration.inDays] only returns the number of whole days.
  Duration difference(JDate other) =>
      toDateTime().difference(other.toDateTime());

  /// Compares two JDate base on their microsecondsSinceEpoch (millisecondsSinceEpoch if running on js environment)
  bool operator >(JDate other) => isJs
      ? _millisecondsSinceEpoch > other.millisecondsSinceEpoch
      : _microsecondsSinceEpoch > other.microsecondsSinceEpoch;

  /// Compares two JDate base on their microsecondsSinceEpoch (millisecondsSinceEpoch if running on js environment)
  bool operator >=(JDate other) => isJs
      ? _millisecondsSinceEpoch >= other.millisecondsSinceEpoch
      : _microsecondsSinceEpoch >= other.microsecondsSinceEpoch;

  /// Compares two JDate base on their microsecondsSinceEpoch (millisecondsSinceEpoch if running on js environment)
  bool operator <(JDate other) => isJs
      ? _millisecondsSinceEpoch > other.millisecondsSinceEpoch
      : _microsecondsSinceEpoch > other.microsecondsSinceEpoch;

  /// Compares two JDate base on their microsecondsSinceEpoch (millisecondsSinceEpoch if running on js environment)
  bool operator <=(JDate other) => isJs
      ? _millisecondsSinceEpoch <= other.millisecondsSinceEpoch
      : _microsecondsSinceEpoch <= other.microsecondsSinceEpoch;

  /// Convert Jalali (Shamsi) Date to Gregorian (Miladi) Date and returns a [BasicDate]
  static BasicDate jalaliToGregorian(int year, int month, int day) =>
      converter.jalaliToGregorian(year, month, day);

  /// Convert Gregorian (Miladi) Date to Jalali (Shamsi) Date and returns a [BasicDate]
  static BasicDate gregorianToJalali(int year, int month, int day) =>
      converter.gregorianToJalali(year, month, day);

  /// Convert Ummalqura (Arabic Hijri Qamari) Date to Gregorian (Miladi) Date and returns a [BasicDate]
  static BasicDate ummalquraToGregorian(int year, int month, int day) =>
      converter.ummalquraToGregorian(year, month, day);

  /// Convert Gregorian (Miladi) Date to Ummalqura (Arabic Hijri Qamari) Date and returns a [BasicDate]
  static BasicDate gregorianToUmmalqura(int year, int month, int day) =>
      converter.gregorianToUmmalqura(year, month, day);

  /// Convert Ummalqura (Arabic Hijri Qamari) Date to Jalali (Shamsi) Date and returns a [BasicDate]
  static BasicDate ummalquraToJalali(int year, int month, int day) {
    final date = converter.ummalquraToGregorian(year, month, day);
    return converter.gregorianToJalali(date.year, date.month, date.day);
  }

  /// Convert Jalali (Shamsi) Date to Ummalqura (Arabic Hijri Qamari) Date and returns a [BasicDate]
  static BasicDate jalaliToUmmalqura(int year, int month, int day) {
    final date = converter.jalaliToGregorian(year, month, day);
    return converter.gregorianToUmmalqura(date.year, date.month, date.day);
  }

  /// Convert Jalali (Shamsi) Date to Islamic (Persian Hijri Qamari) Date and returns a [BasicDate]
  static BasicDate jalaliToIslamic(int year, int month, int day) {
    final date = converter.jalaliToGregorian(year, month, day);
    return converter.gregorianToIslamic(date.year, date.month, date.day);
  }

  /// Convert Islamic (Persian Hijri Qamari) Date to Jalali (Shamsi) Date and returns a [BasicDate]
  static BasicDate islamicToJalali(int year, int month, int day) {
    final date = converter.islamicToGregorian(year, month, day);
    return converter.gregorianToJalali(date.year, date.month, date.day);
  }

  /// Convert Gregorian (Miladi) Date to Islamic (Persian Hijri Qamari) Date and returns a [BasicDate]
  static BasicDate gregorianToIslamic(int year, int month, int day) =>
      converter.gregorianToIslamic(year, month, day);

  /// Convert Islamic (Persian Hijri Qamari) Date to Gregorian (Miladi) Date and returns a [BasicDate]
  static BasicDate islamicToGregorian(int year, int month, int day) =>
      converter.islamicToGregorian(year, month, day);

  /// Compares this JDate object to [other],
  /// returning zero if the values are equal.
  ///
  /// Returns a negative value if this JDate [isBefore] [other]. It returns 0
  /// if it [isAtSameMomentAs] [other], and returns a positive value otherwise
  /// (when this [isAfter] [other]).
  @override
  int compareTo(JDate other) => toDateTime().compareTo(other.toDateTime());

  /// Returns an ISO-8601 full-precision extended format representation.
  ///
  /// The format is `yyyy-MM-ddTHH:mm:ss.mmmuuuZ` for UTC time, and
  /// `yyyy-MM-ddTHH:mm:ss.mmmuuu` (no trailing 'Z') for local/non-UTC time,
  /// where:
  ///
  /// * `yyyy` is a, possibly negative, four digit representation of the year,
  ///   if the year is in the range -9999 to 9999,
  ///   otherwise it is a signed six digit representation of the year.
  /// * `MM` is the month in the range 01 to 12,
  /// * `dd` is the day of the month in the range 01 to 31,
  /// * `HH` are hours in the range 00 to 23,
  /// * `mm` are minutes in the range 00 to 59,
  /// * `ss` are seconds in the range 00 to 59 (no leap seconds),
  /// * `mmm` are milliseconds in the range 000 to 999, and
  /// * `uuu` are microseconds in the range 001 to 999. If [microsecond] equals
  ///   0, then this part is omitted.
  ///
  /// The resulting string can be parsed back using [parse].
  String toIso8601String() {
    var y =
        (year >= -9999 && year <= 9999) ? _fourDigits(year) : _sixDigits(year);
    var m = _twoDigits(month);
    var d = _twoDigits(day);
    var h = _twoDigits(hour);
    var min = _twoDigits(minute);
    var sec = _twoDigits(second);
    var ms = _threeDigits(millisecond);
    var us = microsecond == 0 ? '' : _threeDigits(microsecond);
    if (isUtc) {
      return '$y-$m-${d}T$h:$min:$sec.$ms${us}Z';
    } else {
      return '$y-$m-${d}T$h:$min:$sec.$ms$us';
    }
  }

  /// Returns this JDate value in the UTC time zone.
  ///
  /// Returns [this] if it is already in UTC.
  /// Otherwise this method is equivalent to:
  ///
  /// ```
  /// new JDate.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch,
  ///                                         isUtc: true)
  /// ```
  JDate toUtc() {
    if (_isUtc) return this;
    return isJs
        ? JDate.fromMillisecondsSinceEpoch(_millisecondsSinceEpoch, isUtc: true)
        : JDate.fromMicrosecondsSinceEpoch(_microsecondsSinceEpoch,
            isUtc: true);
  }

  /// Returns this JDate value in the local time zone.
  ///
  /// Returns [this] if it is already in the local time zone.
  /// Otherwise this method is equivalent to:
  ///
  /// ```
  /// new JDate.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch,
  ///                                         isUtc: false)
  /// ```
  JDate toLocal() {
    if (isUtc) {
      return isJs
          ? JDate.fromMillisecondsSinceEpoch(_millisecondsSinceEpoch,
              isUtc: false)
          : JDate.fromMicrosecondsSinceEpoch(_microsecondsSinceEpoch,
              isUtc: false);
    }
    return this;
  }
}
