import 'package:jdate/src/consts.dart';

extension PersianIntegerHelper on int? {
  // Convert numbers to Persian Words
  //
  // ex:
  // ```dart
  // 919.toPersianWords() == نهصد و نوزده
  //```
  // you can also set [ordinal] parameter to `true`
  //
  // ex:
  // ```dart
  // 919.toPersianWords(true)` == نهصد و نوزدهم
  // ```
  String toPersianWords([ordinal = false]) {
    final _this = this;
    if (_this == null) return 'NaN';
    if (this == 0) return 'صفر';
    if (ordinal && _this.isNegative) throw 'Ordinal can\'t be negative';

    var result = _this.isNegative ? 'منفی ' : '';
    final number = _this.abs();

    if (number.toString().length <= 3) {
      var d12 = number % 100;
      var d3 = (number / 100).floor();

      if (d3 != 0) {
        result += persianNumHundreds[d3] + ' و ';
      }

      if ((d12 >= 10) && (d12 <= 19)) {
        result += persianNumTen_Twenty[d12 - 10];
      } else {
        var d2 = (d12 / 10).floor();
        if (d2 != 0) {
          result += persianNumDecimal[d2] + ' و ';
        }

        var d1 = d12 % 10;
        if (d1 != 0) {
          result += persianNumUnit[d1] + ' و ';
        }

        result = result.substring(0, result.length - 3);
      }
    } else {
      var padLen;
      switch (number.toString().length % 3) {
        case 1:
          padLen = 2;
          break;
        case 2:
          padLen = 1;
          break;
        default:
          padLen = 0;
      }
      var numStr = number
          .toString()
          .padLeft(number.toString().length + padLen as int, '0');
      final L = (numStr.length / 3 - 1).floor();
      int b;
      var threeZero = false;
      for (var i = 0; i <= L; i++) {
        b = int.parse(numStr.substring(i * 3, (i + 1) * 3));
        if (b != 0) {
          result += b.toPersianWords() + ' ' + persianNumBase[L - i] + ' و ';
          threeZero = false;
        } else if (b == 0 && i > 0) {
          threeZero = true;
        }
      }
      result = result.substring(
        0,
        threeZero ? result.length - 3 : result.length - 4,
      );
    }

    result = result.trim();

    if (!ordinal) {
      return result;
    } else {
      if (this == 1) {
        return 'اول';
      } else if (result.substring(result.length - 2, result.length) == 'سه') {
        return result.substring(0, result.length - 1) + 'وم';
      } else if (result.substring(result.length - 2, result.length) == 'سی') {
        return result + '‌ام';
      } else {
        return result + 'م';
      }
    }
  }
}
