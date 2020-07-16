import 'package:jdate/jdate.dart';
import 'package:test/test.dart';

void main() {
  // https://kitset.ir/numbers/digits-to-words for convert tests
  group('Number Extension Test', () {
    test('toPersianWords', () {
      //one digits
      expect(1.toPersianWords(), 'یک');
      expect(2.toPersianWords(), 'دو');
      expect(3.toPersianWords(), 'سه');
      expect(4.toPersianWords(), 'چهار');
      expect(5.toPersianWords(), 'پنج');
      expect(6.toPersianWords(), 'شش');
      expect(7.toPersianWords(), 'هفت');
      expect(8.toPersianWords(), 'هشت');
      expect(9.toPersianWords(), 'نه');

      //two digits
      expect(10.toPersianWords(), 'ده');
      expect(11.toPersianWords(), 'یازده');
      expect(12.toPersianWords(), 'دوازده');
      expect(13.toPersianWords(), 'سیزده');
      expect(14.toPersianWords(), 'چهارده');
      expect(15.toPersianWords(), 'پانزده');
      expect(16.toPersianWords(), 'شانزده');
      expect(17.toPersianWords(), 'هفده');
      expect(18.toPersianWords(), 'هجده');
      expect(19.toPersianWords(), 'نوزده');

      expect(20.toPersianWords(), 'بیست');
      expect(30.toPersianWords(), 'سی');
      expect(40.toPersianWords(), 'چهل');
      expect(50.toPersianWords(), 'پنجاه');
      expect(60.toPersianWords(), 'شصت');
      expect(70.toPersianWords(), 'هفتاد');
      expect(80.toPersianWords(), 'هشتاد');
      expect(90.toPersianWords(), 'نود');

      expect(21.toPersianWords(), 'بیست و یک');
      expect(32.toPersianWords(), 'سی و دو');
      expect(43.toPersianWords(), 'چهل و سه');
      expect(54.toPersianWords(), 'پنجاه و چهار');
      expect(65.toPersianWords(), 'شصت و پنج');
      expect(76.toPersianWords(), 'هفتاد و شش');
      expect(87.toPersianWords(), 'هشتاد و هفت');
      expect(98.toPersianWords(), 'نود و هشت');
      expect(99.toPersianWords(), 'نود و نه');

      //three digits
      expect(100.toPersianWords(), 'یکصد');
      expect(200.toPersianWords(), 'دویست');
      expect(300.toPersianWords(), 'سیصد');
      expect(400.toPersianWords(), 'چهارصد');
      expect(500.toPersianWords(), 'پانصد');
      expect(600.toPersianWords(), 'ششصد');
      expect(700.toPersianWords(), 'هفتصد');
      expect(800.toPersianWords(), 'هشتصد');
      expect(900.toPersianWords(), 'نهصد');

      expect(919.toPersianWords(), 'نهصد و نوزده');
      expect(828.toPersianWords(), 'هشتصد و بیست و هشت');
      expect(737.toPersianWords(), 'هفتصد و سی و هفت');
      expect(146.toPersianWords(), 'یکصد و چهل و شش');
      expect(255.toPersianWords(), 'دویست و پنجاه و پنج');
      expect(366.toPersianWords(), 'سیصد و شصت و شش');
      expect(474.toPersianWords(), 'چهارصد و هفتاد و چهار');
      expect(583.toPersianWords(), 'پانصد و هشتاد و سه');
      expect(692.toPersianWords(), 'ششصد و نود و دو');
      expect(791.toPersianWords(), 'هفتصد و نود و یک');

      //four digits
      expect(1000.toPersianWords(), 'یک هزار');
      expect(2000.toPersianWords(), 'دو هزار');
      expect(3000.toPersianWords(), 'سه هزار');
      expect(3010.toPersianWords(), 'سه هزار و ده');
      expect(4110.toPersianWords(), 'چهار هزار و یکصد و ده');
      expect(5215.toPersianWords(), 'پنج هزار و دویست و پانزده');
      expect(6755.toPersianWords(), 'شش هزار و هفتصد و پنجاه و پنج');
      expect(7108.toPersianWords(), 'هفت هزار و یکصد و هشت');
      expect(8001.toPersianWords(), 'هشت هزار و یک');
      expect(9011.toPersianWords(), 'نه هزار و یازده');

      //others
      expect(12345.toPersianWords(), 'دوازده هزار و سیصد و چهل و پنج');
      expect(123456.toPersianWords(),
          'یکصد و بیست و سه هزار و چهارصد و پنجاه و شش');
      expect(1234567.toPersianWords(),
          'یک میلیون و دویست و سی و چهار هزار و پانصد و شصت و هفت');
      expect(12345678.toPersianWords(),
          'دوازده میلیون و سیصد و چهل و پنج هزار و ششصد و هفتاد و هشت');
      expect(123456789.toPersianWords(),
          'یکصد و بیست و سه میلیون و چهارصد و پنجاه و شش هزار و هفتصد و هشتاد و نه');
      expect(1234567890.toPersianWords(),
          'یک میلیارد و دویست و سی و چهار میلیون و پانصد و شصت و هفت هزار و هشتصد و نود');
      expect(98765432121.toPersianWords(),
          'نود و هشت میلیارد و هفتصد و شصت و پنج میلیون و چهارصد و سی و دو هزار و یکصد و بیست و یک');
      expect(546789231354.toPersianWords(),
          'پانصد و چهل و شش میلیارد و هفتصد و هشتاد و نه میلیون و دویست و سی و یک هزار و سیصد و پنجاه و چهار');
      expect(3164849789756.toPersianWords(),
          'سه بیلیون و یکصد و شصت و چهار میلیارد و هشتصد و چهل و نه میلیون و هفتصد و هشتاد و نه هزار و هفتصد و پنجاه و شش');
      expect(23644989879846.toPersianWords(),
          'بیست و سه بیلیون و ششصد و چهل و چهار میلیارد و نهصد و هشتاد و نه میلیون و هشتصد و هفتاد و نه هزار و هشتصد و چهل و شش');
      expect(021516548498498.toPersianWords(),
          'بیست و یک بیلیون و پانصد و شانزده میلیارد و پانصد و چهل و هشت میلیون و چهارصد و نود و هشت هزار و چهارصد و نود و هشت');
      expect(521516548498498.toPersianWords(),
          'پانصد و بیست و یک بیلیون و پانصد و شانزده میلیارد و پانصد و چهل و هشت میلیون و چهارصد و نود و هشت هزار و چهارصد و نود و هشت');
      expect(3546000000649498.toPersianWords(),
          'سه بیلیارد و پانصد و چهل و شش بیلیون و ششصد و چهل و نه هزار و چهارصد و نود و هشت');
      expect(10000000000000000.toPersianWords(), 'ده بیلیارد');
      expect(100000000000000001.toPersianWords(), 'یکصد بیلیارد و یک');
      expect(
          1000000001000000001.toPersianWords(), 'یک تریلیون و یک میلیارد و یک');

      //some special forms
      expect(10001.toPersianWords(), 'ده هزار و یک');
      expect(100100.toPersianWords(), 'یکصد هزار و یکصد');
      expect(10101010.toPersianWords(), 'ده میلیون و یکصد و یک هزار و ده');
      expect(1020300.toPersianWords(), 'یک میلیون و بیست هزار و سیصد');
      expect(10203004.toPersianWords(), 'ده میلیون و دویست و سه هزار و چهار');
      expect(10110110110.toPersianWords(),
          'ده میلیارد و یکصد و ده میلیون و یکصد و ده هزار و یکصد و ده');
    });

    test('toPersianWords(true)', () {
      //one digits
      expect(1.toPersianWords(true), 'اول');
      expect(2.toPersianWords(true), 'دوم');
      expect(3.toPersianWords(true), 'سوم');
      expect(4.toPersianWords(true), 'چهارم');
      expect(5.toPersianWords(true), 'پنجم');
      expect(6.toPersianWords(true), 'ششم');
      expect(7.toPersianWords(true), 'هفتم');
      expect(8.toPersianWords(true), 'هشتم');
      expect(9.toPersianWords(true), 'نهم');

      //two digits
      expect(10.toPersianWords(true), 'دهم');
      expect(11.toPersianWords(true), 'یازدهم');
      expect(12.toPersianWords(true), 'دوازدهم');
      expect(13.toPersianWords(true), 'سیزدهم');
      expect(14.toPersianWords(true), 'چهاردهم');
      expect(15.toPersianWords(true), 'پانزدهم');
      expect(16.toPersianWords(true), 'شانزدهم');
      expect(17.toPersianWords(true), 'هفدهم');
      expect(18.toPersianWords(true), 'هجدهم');
      expect(19.toPersianWords(true), 'نوزدهم');

      expect(20.toPersianWords(true), 'بیستم');
      expect(30.toPersianWords(true), 'سی‌ام');
      expect(40.toPersianWords(true), 'چهلم');
      expect(50.toPersianWords(true), 'پنجاهم');
      expect(60.toPersianWords(true), 'شصتم');
      expect(70.toPersianWords(true), 'هفتادم');
      expect(80.toPersianWords(true), 'هشتادم');
      expect(90.toPersianWords(true), 'نودم');

      expect(21.toPersianWords(true), 'بیست و یکم');
      expect(32.toPersianWords(true), 'سی و دوم');
      expect(43.toPersianWords(true), 'چهل و سوم');
      expect(54.toPersianWords(true), 'پنجاه و چهارم');
      expect(65.toPersianWords(true), 'شصت و پنجم');
      expect(76.toPersianWords(true), 'هفتاد و ششم');
      expect(87.toPersianWords(true), 'هشتاد و هفتم');
      expect(98.toPersianWords(true), 'نود و هشتم');
      expect(99.toPersianWords(true), 'نود و نهم');

      //three digits
      expect(100.toPersianWords(true), 'یکصدم');
      expect(200.toPersianWords(true), 'دویستم');
      expect(300.toPersianWords(true), 'سیصدم');
      expect(400.toPersianWords(true), 'چهارصدم');
      expect(500.toPersianWords(true), 'پانصدم');
      expect(600.toPersianWords(true), 'ششصدم');
      expect(700.toPersianWords(true), 'هفتصدم');
      expect(800.toPersianWords(true), 'هشتصدم');
      expect(900.toPersianWords(true), 'نهصدم');

      expect(919.toPersianWords(true), 'نهصد و نوزدهم');
      expect(828.toPersianWords(true), 'هشتصد و بیست و هشتم');
      expect(737.toPersianWords(true), 'هفتصد و سی و هفتم');
      expect(146.toPersianWords(true), 'یکصد و چهل و ششم');
      expect(255.toPersianWords(true), 'دویست و پنجاه و پنجم');
      expect(366.toPersianWords(true), 'سیصد و شصت و ششم');
      expect(474.toPersianWords(true), 'چهارصد و هفتاد و چهارم');
      expect(583.toPersianWords(true), 'پانصد و هشتاد و سوم');
      expect(692.toPersianWords(true), 'ششصد و نود و دوم');
      expect(791.toPersianWords(true), 'هفتصد و نود و یکم');

      //four digits
      expect(1000.toPersianWords(true), 'یک هزارم');
      expect(2000.toPersianWords(true), 'دو هزارم');
      expect(3000.toPersianWords(true), 'سه هزارم');
      expect(3010.toPersianWords(true), 'سه هزار و دهم');
      expect(4110.toPersianWords(true), 'چهار هزار و یکصد و دهم');
      expect(5215.toPersianWords(true), 'پنج هزار و دویست و پانزدهم');
      expect(6755.toPersianWords(true), 'شش هزار و هفتصد و پنجاه و پنجم');
      expect(7108.toPersianWords(true), 'هفت هزار و یکصد و هشتم');
      expect(8001.toPersianWords(true), 'هشت هزار و یکم');
      expect(9011.toPersianWords(true), 'نه هزار و یازدهم');
    });
  });
}
