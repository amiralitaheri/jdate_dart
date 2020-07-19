import 'package:jdate/src/date_base.dart';
import 'package:test/test.dart';

void main() {
  group('Date Base', () {
    test('Constructor', () {
      final date = DateBase(1377, 01, 02);
      expect(date.year, 1377);
      expect(date.month, 1);
      expect(date.day, 2);
    });

    test('Equal', () {
      assert(DateBase(1377, 01, 01) == DateBase(1377, 01, 01));
      expect(DateBase(1377, 01, 01), DateBase(1377, 01, 01));
    });

    test('Compare', () {
      expect(DateBase(1377, 01, 01).compareTo(DateBase(1377, 01, 01)), 0);
      expect(DateBase(1377, 01, 02).compareTo(DateBase(1377, 01, 01)), 1);
      expect(DateBase(1377, 01, 01).compareTo(DateBase(1377, 01, 02)), -1);
      expect(DateBase(1377, 02, 01).compareTo(DateBase(1377, 01, 02)), 1);
      expect(DateBase(1377, 01, 02).compareTo(DateBase(1377, 02, 02)), -1);
      expect(DateBase(1378, 01, 02).compareTo(DateBase(1377, 02, 02)), 1);
      expect(DateBase(1378, 01, 02).compareTo(DateBase(1377, 11, 11)), 1);
      expect(DateBase(1377, 01, 01).compareTo(DateBase(1377, 02, 02)), -1);
      expect(DateBase(1377, 01, 01).compareTo(DateBase(1378, 02, 02)), -1);
      expect(DateBase(1377, 11, 11).compareTo(DateBase(1378, 02, 02)), -1);
    });

    test('Operator ==', () {
      expect(DateBase(1377, 01, 01) == DateBase(1377, 01, 01), true);
      expect(DateBase(1377, 01, 02) == DateBase(1377, 01, 01), false);
      expect(DateBase(1377, 01, 01) == DateBase(1377, 01, 02), false);
      expect(DateBase(1377, 02, 01) == DateBase(1377, 01, 02), false);
      expect(DateBase(1377, 01, 02) == DateBase(1377, 02, 02), false);
      expect(DateBase(1378, 01, 02) == DateBase(1377, 02, 02), false);
      expect(DateBase(1378, 01, 02) == DateBase(1377, 11, 11), false);
      expect(DateBase(1377, 01, 01) == DateBase(1377, 02, 02), false);
      expect(DateBase(1377, 01, 01) == DateBase(1378, 02, 02), false);
      expect(DateBase(1377, 11, 11) == DateBase(1378, 02, 02), false);
    });

    test('Operator >', () {
      expect(DateBase(1377, 01, 01) > DateBase(1377, 01, 01), false);
      expect(DateBase(1377, 01, 02) > DateBase(1377, 01, 01), true);
      expect(DateBase(1377, 01, 01) > DateBase(1377, 01, 02), false);
      expect(DateBase(1377, 02, 01) > DateBase(1377, 01, 02), true);
      expect(DateBase(1377, 01, 02) > DateBase(1377, 02, 02), false);
      expect(DateBase(1378, 01, 02) > DateBase(1377, 02, 02), true);
      expect(DateBase(1378, 01, 02) > DateBase(1377, 11, 11), true);
      expect(DateBase(1377, 01, 01) > DateBase(1377, 02, 02), false);
      expect(DateBase(1377, 01, 01) > DateBase(1378, 02, 02), false);
      expect(DateBase(1377, 11, 11) > DateBase(1378, 02, 02), false);
    });

    test('Operator >=', () {
      expect(DateBase(1377, 01, 01) >= DateBase(1377, 01, 01), true);
      expect(DateBase(1377, 01, 02) >= DateBase(1377, 01, 01), true);
      expect(DateBase(1377, 01, 01) >= DateBase(1377, 01, 02), false);
      expect(DateBase(1377, 02, 01) >= DateBase(1377, 01, 02), true);
      expect(DateBase(1377, 01, 02) >= DateBase(1377, 02, 02), false);
      expect(DateBase(1378, 01, 02) >= DateBase(1377, 02, 02), true);
      expect(DateBase(1378, 01, 02) >= DateBase(1377, 11, 11), true);
      expect(DateBase(1377, 01, 01) >= DateBase(1377, 02, 02), false);
      expect(DateBase(1377, 01, 01) >= DateBase(1378, 02, 02), false);
      expect(DateBase(1377, 11, 11) >= DateBase(1378, 02, 02), false);
    });

    test('Operator <', () {
      expect(DateBase(1377, 01, 01) < DateBase(1377, 01, 01), false);
      expect(DateBase(1377, 01, 02) < DateBase(1377, 01, 01), false);
      expect(DateBase(1377, 01, 01) < DateBase(1377, 01, 02), true);
      expect(DateBase(1377, 02, 01) < DateBase(1377, 01, 02), false);
      expect(DateBase(1377, 01, 02) < DateBase(1377, 02, 02), true);
      expect(DateBase(1378, 01, 02) < DateBase(1377, 02, 02), false);
      expect(DateBase(1378, 01, 02) < DateBase(1377, 11, 11), false);
      expect(DateBase(1377, 01, 01) < DateBase(1377, 02, 02), true);
      expect(DateBase(1377, 01, 01) < DateBase(1378, 02, 02), true);
      expect(DateBase(1377, 11, 11) < DateBase(1378, 02, 02), true);
    });

    test('Operator <=', () {
      expect(DateBase(1377, 01, 01) <= DateBase(1377, 01, 01), true);
      expect(DateBase(1377, 01, 02) <= DateBase(1377, 01, 01), false);
      expect(DateBase(1377, 01, 01) <= DateBase(1377, 01, 02), true);
      expect(DateBase(1377, 02, 01) <= DateBase(1377, 01, 02), false);
      expect(DateBase(1377, 01, 02) <= DateBase(1377, 02, 02), true);
      expect(DateBase(1378, 01, 02) <= DateBase(1377, 02, 02), false);
      expect(DateBase(1378, 01, 02) <= DateBase(1377, 11, 11), false);
      expect(DateBase(1377, 01, 01) <= DateBase(1377, 02, 02), true);
      expect(DateBase(1377, 01, 01) <= DateBase(1378, 02, 02), true);
      expect(DateBase(1377, 11, 11) <= DateBase(1378, 02, 02), true);
    });
  });
}
