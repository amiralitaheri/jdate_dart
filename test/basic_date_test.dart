import 'package:jdate/src/basic_date.dart';
import 'package:test/test.dart';

void main() {
  group('Date Base', () {
    test('Constructor', () {
      final date = BasicDate(1377, 01, 02);
      expect(date.year, 1377);
      expect(date.month, 1);
      expect(date.day, 2);
    });

    test('Equal', () {
      assert(BasicDate(1377, 01, 01) == BasicDate(1377, 01, 01));
      expect(BasicDate(1377, 01, 01), BasicDate(1377, 01, 01));
    });

    test('Compare', () {
      expect(BasicDate(1377, 01, 01).compareTo(BasicDate(1377, 01, 01)), 0);
      expect(BasicDate(1377, 01, 02).compareTo(BasicDate(1377, 01, 01)), 1);
      expect(BasicDate(1377, 01, 01).compareTo(BasicDate(1377, 01, 02)), -1);
      expect(BasicDate(1377, 02, 01).compareTo(BasicDate(1377, 01, 02)), 1);
      expect(BasicDate(1377, 01, 02).compareTo(BasicDate(1377, 02, 02)), -1);
      expect(BasicDate(1378, 01, 02).compareTo(BasicDate(1377, 02, 02)), 1);
      expect(BasicDate(1378, 01, 02).compareTo(BasicDate(1377, 11, 11)), 1);
      expect(BasicDate(1377, 01, 01).compareTo(BasicDate(1377, 02, 02)), -1);
      expect(BasicDate(1377, 01, 01).compareTo(BasicDate(1378, 02, 02)), -1);
      expect(BasicDate(1377, 11, 11).compareTo(BasicDate(1378, 02, 02)), -1);
    });

    test('Operator ==', () {
      expect(BasicDate(1377, 01, 01) == BasicDate(1377, 01, 01), true);
      expect(BasicDate(1377, 01, 02) == BasicDate(1377, 01, 01), false);
      expect(BasicDate(1377, 01, 01) == BasicDate(1377, 01, 02), false);
      expect(BasicDate(1377, 02, 01) == BasicDate(1377, 01, 02), false);
      expect(BasicDate(1377, 01, 02) == BasicDate(1377, 02, 02), false);
      expect(BasicDate(1378, 01, 02) == BasicDate(1377, 02, 02), false);
      expect(BasicDate(1378, 01, 02) == BasicDate(1377, 11, 11), false);
      expect(BasicDate(1377, 01, 01) == BasicDate(1377, 02, 02), false);
      expect(BasicDate(1377, 01, 01) == BasicDate(1378, 02, 02), false);
      expect(BasicDate(1377, 11, 11) == BasicDate(1378, 02, 02), false);
    });

    test('Operator >', () {
      expect(BasicDate(1377, 01, 01) > BasicDate(1377, 01, 01), false);
      expect(BasicDate(1377, 01, 02) > BasicDate(1377, 01, 01), true);
      expect(BasicDate(1377, 01, 01) > BasicDate(1377, 01, 02), false);
      expect(BasicDate(1377, 02, 01) > BasicDate(1377, 01, 02), true);
      expect(BasicDate(1377, 01, 02) > BasicDate(1377, 02, 02), false);
      expect(BasicDate(1378, 01, 02) > BasicDate(1377, 02, 02), true);
      expect(BasicDate(1378, 01, 02) > BasicDate(1377, 11, 11), true);
      expect(BasicDate(1377, 01, 01) > BasicDate(1377, 02, 02), false);
      expect(BasicDate(1377, 01, 01) > BasicDate(1378, 02, 02), false);
      expect(BasicDate(1377, 11, 11) > BasicDate(1378, 02, 02), false);
    });

    test('Operator >=', () {
      expect(BasicDate(1377, 01, 01) >= BasicDate(1377, 01, 01), true);
      expect(BasicDate(1377, 01, 02) >= BasicDate(1377, 01, 01), true);
      expect(BasicDate(1377, 01, 01) >= BasicDate(1377, 01, 02), false);
      expect(BasicDate(1377, 02, 01) >= BasicDate(1377, 01, 02), true);
      expect(BasicDate(1377, 01, 02) >= BasicDate(1377, 02, 02), false);
      expect(BasicDate(1378, 01, 02) >= BasicDate(1377, 02, 02), true);
      expect(BasicDate(1378, 01, 02) >= BasicDate(1377, 11, 11), true);
      expect(BasicDate(1377, 01, 01) >= BasicDate(1377, 02, 02), false);
      expect(BasicDate(1377, 01, 01) >= BasicDate(1378, 02, 02), false);
      expect(BasicDate(1377, 11, 11) >= BasicDate(1378, 02, 02), false);
    });

    test('Operator <', () {
      expect(BasicDate(1377, 01, 01) < BasicDate(1377, 01, 01), false);
      expect(BasicDate(1377, 01, 02) < BasicDate(1377, 01, 01), false);
      expect(BasicDate(1377, 01, 01) < BasicDate(1377, 01, 02), true);
      expect(BasicDate(1377, 02, 01) < BasicDate(1377, 01, 02), false);
      expect(BasicDate(1377, 01, 02) < BasicDate(1377, 02, 02), true);
      expect(BasicDate(1378, 01, 02) < BasicDate(1377, 02, 02), false);
      expect(BasicDate(1378, 01, 02) < BasicDate(1377, 11, 11), false);
      expect(BasicDate(1377, 01, 01) < BasicDate(1377, 02, 02), true);
      expect(BasicDate(1377, 01, 01) < BasicDate(1378, 02, 02), true);
      expect(BasicDate(1377, 11, 11) < BasicDate(1378, 02, 02), true);
    });

    test('Operator <=', () {
      expect(BasicDate(1377, 01, 01) <= BasicDate(1377, 01, 01), true);
      expect(BasicDate(1377, 01, 02) <= BasicDate(1377, 01, 01), false);
      expect(BasicDate(1377, 01, 01) <= BasicDate(1377, 01, 02), true);
      expect(BasicDate(1377, 02, 01) <= BasicDate(1377, 01, 02), false);
      expect(BasicDate(1377, 01, 02) <= BasicDate(1377, 02, 02), true);
      expect(BasicDate(1378, 01, 02) <= BasicDate(1377, 02, 02), false);
      expect(BasicDate(1378, 01, 02) <= BasicDate(1377, 11, 11), false);
      expect(BasicDate(1377, 01, 01) <= BasicDate(1377, 02, 02), true);
      expect(BasicDate(1377, 01, 01) <= BasicDate(1378, 02, 02), true);
      expect(BasicDate(1377, 11, 11) <= BasicDate(1378, 02, 02), true);
    });
  });
}
