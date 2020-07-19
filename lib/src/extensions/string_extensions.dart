extension PersianStringHelper on String {
  // Translate All Persian and Arabic number characters to English
  //
  // ex:
  // ```dart
  // ۴ or ٤ => 4
  // ```
  String numbersToEnglish() => replaceAll(RegExp(r'[۰٠]'), '0')
      .replaceAll(RegExp(r'[۱١]'), '1')
      .replaceAll(RegExp(r'[۲٢]'), '2')
      .replaceAll(RegExp(r'[۳٣]'), '3')
      .replaceAll(RegExp(r'[۴٤]'), '4')
      .replaceAll(RegExp(r'[۵٥]'), '5')
      .replaceAll(RegExp(r'[۶٦]'), '6')
      .replaceAll(RegExp(r'[۷٧]'), '7')
      .replaceAll(RegExp(r'[۸٨]'), '8')
      .replaceAll(RegExp(r'[۹٩]'), '9');

  //todo: add arabic to converter
  // Translate All English number characters to Persian
  //
  // ex: ```dart
  // 1 => ۱
  // ```
  String numbersToPersian() => replaceAll(RegExp(r'[0٠]'), '۰')
      .replaceAll(RegExp(r'[1١]'), '۱')
      .replaceAll(RegExp(r'[2٢]'), '۲')
      .replaceAll(RegExp(r'[3٣]'), '۳')
      .replaceAll(RegExp(r'[4٤]'), '۴')
      .replaceAll(RegExp(r'[5٥]'), '۵')
      .replaceAll(RegExp(r'[6٦]'), '۶')
      .replaceAll(RegExp(r'[7٧]'), '۷')
      .replaceAll(RegExp(r'[8٨]'), '۸')
      .replaceAll(RegExp(r'[9٩]'), '۹');
}
