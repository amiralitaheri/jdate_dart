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
  String numbersToPersian() => replaceAll('0', '۰')
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
