import 'package:jdate/jdate.dart';
import 'package:test/test.dart';

void main() {
  // http://www.saitak.com/number for convert tests
  group('String Extension Test', () {
    final firstEn = '1234567891234567899876543210';
    final secondEn = '1-2-3-4-5-6-7-8-9-10-15-20-25-100-564';
    final thirdEn = '1234567890';
    final forthEn = '1ok2ok3hello4do5you678-90';

    final firstFa = '۱۲۳۴۵۶۷۸۹۱۲۳۴۵۶۷۸۹۹۸۷۶۵۴۳۲۱۰';
    final secondFa = '۱-۲-۳-۴-۵-۶-۷-۸-۹-۱۰-۱۵-۲۰-۲۵-۱۰۰-۵۶۴';
    final thirdFa = '۱۲۳۴۵۶۷۸۹۰';
    final forthFa = '۱ok۲ok۳hello۴do۵you۶۷۸-۹۰';

    final firstAr = '۱۲۳٤٥٦۷۸۹۱۲۳٤٥٦۷۸۹۹۸۷٦٥٤۳۲۱۰';
    final secondAr = '۱-۲-۳-٤-٥-٦-۷-۸-۹-۱۰-۱٥-۲۰-۲٥-۱۰۰-٥٦٤';
    final thirdAr = '۱۲۳٤٥٦۷۸۹۰';
    final forthAr = '۱ok۲ok۳hello٤do٥you٦۷۸-۹۰';

    test('numbersToEnglish', () {
      expect(''.numbersToEnglish(), '');
      expect('  '.numbersToEnglish(), '  ');

      expect(firstFa.numbersToEnglish(), firstEn);
      expect(secondFa.numbersToEnglish(), secondEn);
      expect(thirdFa.numbersToEnglish(), thirdEn);
      expect(forthFa.numbersToEnglish(), forthEn);

      expect(firstAr.numbersToEnglish(), firstEn);
      expect(secondAr.numbersToEnglish(), secondEn);
      expect(thirdAr.numbersToEnglish(), thirdEn);
      expect(forthAr.numbersToEnglish(), forthEn);

      expect((firstFa + secondAr).numbersToEnglish(), firstEn + secondEn);
    });

    test('numbersToPersian', () {
      expect(''.numbersToPersian(), '');
      expect('  '.numbersToPersian(), '  ');

      expect(firstEn.numbersToPersian(), firstFa);
      expect(secondEn.numbersToPersian(), secondFa);
      expect(thirdEn.numbersToPersian(), thirdFa);
      expect(forthEn.numbersToPersian(), forthFa);

      //todo: uncomment after adding arabic
//      expect(firstAr.numbersToPersian(), firstFa);
//      expect(secondAr.numbersToPersian(), secondFa);
//      expect(thirdAr.numbersToPersian(), thirdFa);
//      expect(forthAr.numbersToPersian(), forthFa);
    });
  });
}
