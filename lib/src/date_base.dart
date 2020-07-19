/// This class only holds Date data.
/// The Date Type is't specified so it can be Jalali, Gregorian or Hijri
///
/// ```dart
/// var date = DateBase(1378, 10, 30);
/// ```
class DateBase implements Comparable<DateBase> {
  /// Year of the date
  int year;

  /// Month of the year
  int month;

  /// Day of the month
  int day;

  /// Constructor of [DateBase]
  /// [year], [month] and [day] are int and there is no constraint for it
  DateBase(this.year, this.month, this.day);

  @override
  String toString() => {'year': year, 'month': month, 'day': day}.toString();

  @override
  bool operator ==(other) {
    if (!(other is DateBase)) throw 'Unrelated type equality checks';
    return year == other.year && month == other.month && day == other.day;
  }

  /// Relational greater than operator.
  /// returns true if `this` is greater than [other]
  bool operator >(DateBase other) {
    return compareTo(other) == 1;
  }
  
  /// Relational less than operator.
  /// returns true if `this` is less than [other]
  bool operator <(DateBase other) {
    return compareTo(other) == -1;
  }
  
  /// Relational less than or equal operator.
  /// returns true if `this` is less than or equal [other]
  bool operator <=(DateBase other) {
    return compareTo(other) != 1;
  }

  /// Relational greater than or equal operator.
  /// returns true if `this` is greater than or equal [other]
  bool operator >=(DateBase other) {
    return compareTo(other) != -1;
  }

  // it returns a negative integer if `this` is ordered before `other`,
  // a positive integer if `this` is ordered after `other`,
  // and zero if `this` and `other` are ordered together.
  @override
  int compareTo(DateBase other) {
    if (year > other.year) {
      return 1;
    } else if (year < other.year) {
      return -1;
    } else if (month > other.month) {
      return 1;
    } else if (month < other.month) {
      return -1;
    } else if (day > other.day) {
      return 1;
    } else if (day < other.day) {
      return -1;
    } else {
      return 0;
    }
  }
}
