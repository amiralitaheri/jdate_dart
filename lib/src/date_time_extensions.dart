import 'package:jdate/jdate.dart';

extension PersianDateTimeHelper on DateTime {
  JDate toJDate() {
    return JDate.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch);
  }
}