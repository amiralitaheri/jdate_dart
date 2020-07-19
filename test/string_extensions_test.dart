import 'package:jdate/jdate.dart';
import 'package:test/test.dart';

void main() {
  // http://www.saitak.com/number for convert tests
  group('String Extension Test', () {
    final data = [
      [
        '1234567891234567899876543210',
        '1-2-3-4-5-6-7-8-9-10-15-20-25-100-564',
        '1234567890',
        '1ok2ok3hello4do5you678-90',
      ],
      [
        '۱۲۳۴۵۶۷۸۹۱۲۳۴۵۶۷۸۹۹۸۷۶۵۴۳۲۱۰',
        '۱-۲-۳-۴-۵-۶-۷-۸-۹-۱۰-۱۵-۲۰-۲۵-۱۰۰-۵۶۴',
        '۱۲۳۴۵۶۷۸۹۰',
        '۱ok۲ok۳hello۴do۵you۶۷۸-۹۰',
      ],
      [
        '۱۲۳٤٥٦۷۸۹۱۲۳٤٥٦۷۸۹۹۸۷٦٥٤۳۲۱۰',
        '۱-۲-۳-٤-٥-٦-۷-۸-۹-۱۰-۱٥-۲۰-۲٥-۱۰۰-٥٦٤',
        '۱۲۳٤٥٦۷۸۹۰',
        '۱ok۲ok۳hello٤do٥you٦۷۸-۹۰',
      ],
    ];
    
    test('numbersToEnglish', () {
      for (var i = 0; i < data[0].length; ++i) {
        var english = data[0][i];
        var persian = data[1][i];
        var arabic = data[2][i];
        
        expect(persian.numbersToEnglish(), english);
        expect(arabic.numbersToEnglish(), english);
        expect(arabic.numbersToPersian(), persian);
        expect(english.numbersToPersian(), persian);
        expect((persian + arabic).numbersToEnglish(), english + english);
      }
    });
    
    test('Empty Convert', () {
      expect(''.numbersToPersian(), '');
      expect('  '.numbersToPersian(), '  ');
      expect(''.numbersToEnglish(), '');
      expect('  '.numbersToEnglish(), '  ');
    });
  });
}
