import 'consts.dart';
import 'converters.dart' as converter;
import 'number_extensions.dart';
import 'string_extensions.dart';

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

  set microsecondsSinceEpoch(int microsecondsSinceEpoch) {
    var gregorian = DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch);
    _passDateTimeToInternal(gregorian);
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

  set millisecondsSinceEpoch(int millisecondsSinceEpoch) {
    var gregorian = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    _passDateTimeToInternal(gregorian);
  }

  /// The microsecond [0...999].
  ///
  /// ```
  /// var moonLanding = JDate.parse('1969-07-20 20:18:04Z');
  /// assert(moonLanding.microsecond == 0);
  /// ```
  int get microsecond => _microsecond;

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
  /// var moonLanding = JDate.parse('1969-07-20 20:18:04Z');
  /// assert(moonLanding.day == 29);
  /// ```
  int get day => _day;

  set day(int day) {
    if (day > 0 && day <= getMonthLength()) {
      _day = day;
      var gd = converter.jalaliToGregorian(
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
      _weekday = (gregorian.weekday - 1) % 7;
    } else {
      throw 'Day number out of range';
    }
  }

  /// The month [1..12].
  ///
  /// ```
  /// var moonLanding = JDate.parse('1969-07-20 20:18:04Z');
  /// assert(moonLanding.month == 4);
  /// ```
  int get month => _month;

  set month(int month) {
    if (month > 0 && month <= 12) {
      _month = month;
      var gd = converter.jalaliToGregorian(
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
      _weekday = (gregorian.weekday - 1) % 7;
    } else {
      throw 'Month number out of range';
    }
  }

  /// The year.
  ///
  /// ```
  /// var moonLanding = JDate.parse('1969-07-20 20:18:04Z');
  /// assert(moonLanding.year == 1348);
  /// ```
  int get year => _year;

  set year(int year) {
    if (year > 0) {
      _year = year;
      var gd = converter.jalaliToGregorian(
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
      _weekday = (gregorian.weekday - 1) % 7;
    } else {
      throw 'Year number out of range';
    }
  }

  /// The day of the week شنبه..جمعه.
  ///
  /// a week starts with شنبه, which has the value 1.
  ///
  /// ```
  /// var moonLanding = JDate.parse('1969-07-20 20:18:04Z');
  /// assert(moonLanding.weekday == 1);
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

  /// returns the name of weekDay in persian
  /// ```
  /// var moonLanding = JDate.parse('1969-07-20 20:18:04Z');
  /// assert(moonLanding.weekDayName == 'یکشنبه');
  /// ```
  String get weekDayName => jalaliDays[_weekday]['long'];

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

  /// Constructs a [JDate] instance from given [DateTime].
  ///
  /// ```
  /// var date = DateTime(1977, 5, 12);
  /// var jDate = JDate.fromDateTime(date);
  /// ```
  JDate.fromDateTime(DateTime date) {
    _passDateTimeToInternal(date);
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
    var gregorian = DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch,
        isUtc: isUtc);
    _passDateTimeToInternal(gregorian);
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
    var gregorian = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch,
        isUtc: isUtc);
    _passDateTimeToInternal(gregorian);
  }

  /// Constructs a [JDate] instance with current date and time in the
  /// local time zone.
  ///
  /// ```
  /// var thisInstant = new JDate.now();
  /// ```
  JDate.now() : this.fromDateTime(DateTime.now());

  //todo: change to static method
  JDate.parse(String string) {
    string = string.numbersToEnglish().replaceAll(RegExp(r'[/\\]'), '-');
    var date = DateTime.tryParse(string);
    if (date == null) {
      throw 'Can\'t parse string';
    }
    _passDateTimeToInternal(date);
  }

  void _passDateTimeToInternal(DateTime date) {
    var jalali = converter.gregorianToJalali(date.year, date.month, date.day);
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

  // Main function that set everything in object
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

    //check day in month
    final monthLen = getMonthLength();
    assert(day <= monthLen && day >= 1,
        'Day should be in range of 1-${monthLen} with given month ($_month)');

    //convert jalali to gregorian to get other parameters
    var greg = converter.jalaliToGregorian(year, month, day);
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
    _weekday = (gregorian.weekday + 1) % 7;
    _millisecondsSinceEpoch = gregorian.millisecondsSinceEpoch;
    _microsecondsSinceEpoch = gregorian.microsecondsSinceEpoch;
  }

  static String _withZero(int num) =>
      (num < 10) ? '0' + num.toString() : num.toString();

  int getShortYear() {
    //todo: ask someone
    if (_year >= 1300 && _year < 1400) {
      return int.parse(_year.toString().substring(2)); //1375 -> 75
    } else {
      return _year; //85 -> 85, 1000 -> 1000
    }
  }

  bool isLeapYear() => _year % 33 % 4 - 1 == (_year % 33 * .05).floor();

  /// returns number of days in that month
  ///
  /// ```Dart
  /// var monthDays = JDate.now().getMonthLength();
  /// ```
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
    var jw = _weekday;
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
        .replaceAll('l', jalaliDays[jw]['long'])
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
        .replaceAll('D', jalaliDays[jw]['short'])
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

  /// Returns a human-readable string for this instance.
  ///
  /// The returned string is constructed for the time zone of this instance.
  /// The `toString()` method provides a simply formatted string.
  ///
  /// The resulting string can be parsed back using [parse].
  @override
  String toString() => echo('Y/m/d H:i:s');

  DateTime toDateTime() {
    return DateTime.fromMicrosecondsSinceEpoch(_microsecondsSinceEpoch);
  }

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
  JDate add(Duration duration) {
    return JDate.fromMicrosecondsSinceEpoch(
        _microsecondsSinceEpoch + duration.inMicroseconds);
  }

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
  JDate subtract(Duration duration) {
    return JDate.fromMicrosecondsSinceEpoch(
        _microsecondsSinceEpoch - duration.inMicroseconds);
  }

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
  bool operator ==(dynamic other) {
    throw UnimplementedError;
  }

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
  external bool isAtSameMomentAs(JDate other);

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
  external bool isBefore(JDate other);

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
  external bool isAfter(JDate other);

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

  bool operator >(JDate other) =>
      other.microsecondsSinceEpoch > _microsecondsSinceEpoch;

  bool operator <(JDate other) =>
      other.microsecondsSinceEpoch < _microsecondsSinceEpoch;

  static Map<String, int> jalaliToGregorian(int year, int month, int day) =>
      converter.jalaliToGregorian(year, month, day);

  static Map<String, int> gregorianToJalali(int year, int month, int day) =>
      converter.gregorianToJalali(year, month, day);

  static Map<String, int> hijriToGregorian(int year, int month, int day) =>
      converter.hijriToGregorian(year, month, day);

  static Map<String, int> gregorianToHijri(int year, int month, int day) =>
      converter.gregorianToHijri(year, month, day);

  static Map<String, int> hijriToJalali(int year, int month, int day) {
    var gregorian = converter.hijriToGregorian(year, month, day);
    return converter.gregorianToJalali(
        gregorian['year'], gregorian['month'], gregorian['day']);
  }

  static Map<String, int> jalaliToHijri(int year, int month, int day) {
    var gregorian = converter.jalaliToGregorian(year, month, day);
    return converter.gregorianToHijri(
        gregorian['year'], gregorian['month'], gregorian['day']);
  }

  /// Compares this JDate object to [other],
  /// returning zero if the values are equal.
  ///
  /// Returns a negative value if this JDate [isBefore] [other]. It returns 0
  /// if it [isAtSameMomentAs] [other], and returns a positive value otherwise
  /// (when this [isAfter] [other]).
  @override
  int compareTo(JDate other) =>
      _microsecondsSinceEpoch - other.microsecondsSinceEpoch;

  static String _fourDigits(int n) {
    int absN = n.abs();
    String sign = n < 0 ? "-" : "";
    if (absN >= 1000) return "$n";
    if (absN >= 100) return "${sign}0$absN";
    if (absN >= 10) return "${sign}00$absN";
    return "${sign}000$absN";
  }

  static String _sixDigits(int n) {
    assert(n < -9999 || n > 9999);
    int absN = n.abs();
    String sign = n < 0 ? "-" : "+";
    if (absN >= 100000) return "$sign$absN";
    return "${sign}0$absN";
  }

  static String _threeDigits(int n) {
    if (n >= 100) return "${n}";
    if (n >= 10) return "0${n}";
    return "00${n}";
  }

  static String _twoDigits(int n) {
    if (n >= 10) return "${n}";
    return "0${n}";
  }

  /// Returns an ISO-8601 full-precision extended format representation.
  ///
  /// The format is `yyyy-MM-ddTHH:mm:ss.mmmuuuZ` for UTC time, and
  /// `yyyy-MM-ddTHH:mm:ss.mmmuuu` (no trailing "Z") for local/non-UTC time,
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
    if (isUtc) return this;
    return JDate.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch,
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
      return JDate.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch,
          isUtc: false);
    }
    return this;
  }
}
