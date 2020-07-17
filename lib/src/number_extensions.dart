extension PersianIntegerHelper on int {
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
    const yekan = [
      'صفر',
      'یک',
      'دو',
      'سه',
      'چهار',
      'پنج',
      'شش',
      'هفت',
      'هشت',
      'نه'
    ];
    const dahgan = [
      '',
      '',
      'بیست',
      'سی',
      'چهل',
      'پنجاه',
      'شصت',
      'هفتاد',
      'هشتاد',
      'نود'
    ];
    const dahyek = [
      'ده',
      'یازده',
      'دوازده',
      'سیزده',
      'چهارده',
      'پانزده',
      'شانزده',
      'هفده',
      'هجده',
      'نوزده'
    ];
    const sadgan = [
      '',
      'یکصد',
      'دویست',
      'سیصد',
      'چهارصد',
      'پانصد',
      'ششصد',
      'هفتصد',
      'هشتصد',
      'نهصد'
    ];
    const basegan = [
      '',
      'هزار',
      'میلیون',
      'میلیارد',
      'بیلیون',
      'بیلیارد',
      'تریلیون',
      'تریلیارد'
    ];

    var result = '';

    if (this == 0) return 'صفر';
    if (toString().length <= 3) {
      var d12 = this % 100, d3 = (this / 100).floor();

      if (d3 != 0) {
        result = sadgan[d3] + ' و ';
      }

      if ((d12 >= 10) && (d12 <= 19)) {
        result = result + dahyek[d12 - 10];
      } else {
        var d2 = (d12 / 10).floor();
        if (d2 != 0) {
          result = result + dahgan[d2] + ' و ';
        }

        var d1 = d12 % 10;
        if (d1 != 0) {
          result = result + yekan[d1] + ' و ';
        }

        result = result.substring(0, result.length - 3);
      }
    } else {
      var padLen;
      switch (toString().length % 3) {
        case 1:
          padLen = 2;
          break;
        case 2:
          padLen = 1;
          break;
        default:
          padLen = 0;
      }
      var numStr = toString().padLeft(toString().length + padLen, '0');
      final L = (numStr.length / 3 - 1).floor();
      int b;
      var threeZero = false;
      for (var i = 0; i <= L; i++) {
        b = int.parse(numStr.substring(i * 3, (i + 1) * 3));
        if (b != 0) {
          result += b.toPersianWords() + ' ' + basegan[L - i] + ' و ';
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
