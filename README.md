<p align="center">
    <img src="https://github.com/moghaddam24/JDate.js/blob/master/examples/logo.png?raw=true" alt="logo"><br/>
    Powerful yet original Dart Jalali date and time for developers.
</p>
<p align="center">
    <img src="https://img.shields.io/github/workflow/status/amiralitaheri/jdate_dart/Dart%20CI" alt="CI"/>
    <img src="https://img.shields.io/pub/v/jdate" alt="version"/>
    <img src="https://img.shields.io/github/issues/amiralitaheri/jdate_dart" alt="issues"/>
    <img src="https://img.shields.io/github/languages/top/amiralitaheri/jdate_dart" alt="language"/>
    <img src="https://img.shields.io/github/license/amiralitaheri/jdate_dart" alt="licence"/>
</p>

## Creat a JDate object from DateTime

DateTime extension `toJDate()` creates a JDate object for you:

```
  print(DateTime.now().toJDate());                          // 1399/04/29 16:32:36
  print(DateTime(2020).toJDate());                          // 1398/10/11 00:00:00
  print(DateTime(2020, 7).toJDate());                       // 1399/04/11 00:00:00
  print(DateTime(2020, 7, 16).toJDate());                   // 1399/04/26 00:00:00
  print(DateTime(2020, 7, 16, 12).toJDate());               // 1399/04/26 12:00:00
  print(DateTime(2020, 7, 16, 12, 18).toJDate());           // 1399/04/26 12:18:00
  print(DateTime(2020, 7, 16, 12, 18, 30).toJDate());       // 1399/04/26 12:18:30
  print(DateTime(2020, 7, 16, 12, 18, 30, 450).toJDate());  // 1399/04/26 12:18:30
```
## JDate(year, month, ...) with shamsi date parameters

You can creates a new jalali date object with a specified shamsi date and time.

```
    print(JDate.now());                         // 1399/04/29 16:32:36
    print(JDate(1399));                         // 1399/01/01 00:00:00
    print(JDate(1399, 4));                      // 1399/04/01 00:00:00  
    print(JDate(1399, 4, 15));                  // 1399/04/15 00:00:00
    print(JDate(1399, 4, 15, 20));              // 1399/04/15 20:00:00
    print(JDate(1399, 4, 15, 20, 25));          // 1399/04/15 20:25:00
    print(JDate(1399, 4, 15, 20, 25, 30));      // 1399/04/15 20:25:30
    print(JDate(1399, 4, 15, 20, 25, 30, 650)); // 1399/04/15 20:25:30
```
## Other Constructors
- `JDate.utc(int year, [int month = 1,int day = 1,int hour = 0,int minute = 0,int second = 0,int millisecond = 0,int microsecond = 0 ])`
- `JDate.fromDateTime(DateTime date)`
- `JDate.fromMicrosecondsSinceEpoch(int microsecondsSinceEpoch, {bool isUtc = false})`
- `JDate.fromMillisecondsSinceEpoch(int millisecondsSinceEpoch, {bool isUtc = false})`
- `JDate.now()`

## JDate(...).echo

```
    var jd = JDate(2019, 4, 3, 10, 33, 30, 0);
    print(jd.echo('l، d F Y ساعت H:i:s'));      // چهارشنبه، 03 تیر 2019 ساعت 10:33:30
```
Method|Description|Range|Example
------|-----------|-----|-------
a |  Before noon and afternoon |  ق.ظ - ب.ظ |  ق.ظ | 
b |  Numeric representation of a season, without leading zeros |  0-3 |  1 | 
d |  Day of the month, 2 digits with leading zeros |  01-31 |  13 | 
f |  Season name |  بهار-زمستان |  بهار | 
g |  12-hour format of an hour without leading zeros |  0-12 |  11 | 
h |  12-hour format of an hour with leading zeros |  00-12 |  03 | 
i |  Minutes with leading zeros |  00-59 |  13 | 
j |  Day of the month without leading zeros |  1-31 |  4 | 
l |  A full textual representation of the day of the week |  شنبه-جمعه |  یکشنبه | 
m |  Numeric representation of a month, with leading zeros |  01-12 |  02 | 
n |  Numeric representation of a month, without leading zeros |  1-12 |  2 | 
s |  Seconds, with leading zeros |  00-59 |  03 | 
t |  Number of days in the given month |  0-31 |  28 | 
u |  Millisecond |  000000 |  28 | 
v |  Short year display in letters |  یک-نهصد و نود و نه |  نود و هشت | چهارصد و دو | 
w |  Numeric representation of the day of the week |  0-6 |  6 | 
y |  A two or three digit representation of a year |  1-999 |  98 | 402 | 
A |  Before noon and afternoon |  بعد از ظهر - قبل از ظهر |  قبل از ظهر | 
D |  Persian ordinal suffix for the day of the month, 2 characters |  شن‍ - جم‍ |  سه | 
F |  A full textual representation of a month |  فروردین - اسفند |  اردیبهشت | 
G |  24-hour format of an hour without leading zeros |  0-24 |  3 | 
H |  24-hour format of an hour with leading zeros |  00-24 |  03 | 
J |  Day of the month |  یک-سی و یک |  سیزده | 
L |  Whether it’s a leap year |  0-1 |  1 | 
M |  A short textual representation of a month, two letters |  فر-اس‍ |  ار | 
O |  Difference to Greenwich time (GMT) in hours |  -1200 - +1400 |  +0330 | 
V |  Full year display in letters |  صفر-... |  یک هزار و سیصد و نود و هشت | 
Y |  A full numeric representation of a year, 4 digits |  0-... |  1398 | 



## JDate.parse(...)

You can parse specified shamsi or date from valid date string to convert it to JDate object.  

```
  print(JDate.parse('1399/09/09 13:27:00'));  // 1399/09/09 13:27:00
  print(JDate.parse('1399-09-09 13:27:00'));  // 1399/09/09 13:27:00
  print(JDate.parse('۱۳۹۹/۰۹/۰۹'));           // 1399/09/09 00:00:00
  print(JDate.parse('1399/02/13'));           // 1399/02/13 00:00:00
  print(JDate.parse(JDate(1378).toString())); // 1378/01/01 00:00:00
```    


## JDate Parameters

Parameters|Description|Type|Access
----------|-----------|----|------
microsecondsSinceEpoch | The number of microseconds since the 'Unix epoch' 1970-01-01T00:00:00Z (UTC). | int | read/write
millisecondsSinceEpoch | The number of milliseconds since the 'Unix epoch' 1970-01-01T00:00:00Z (UTC). | int | read/write
microsecond | The microsecond `0...999`. | int | read/write
millisecond | The millisecond `0...999`. | int | read/write
second | The second `0...59`. | int | read/write
minute | The minute `0...59`. | int | read/write
hour | The hour of the day, expressed as in a 24-hour clock `0..23`. | int | read/write
day | The day of the month `1..31`. | int | read/write
month | The month `1..12`. | int | read/write
year | The year. | int | read/write
weekday | The day of the week `1...7`. | int | read
timeZoneOffset | Difference between local time and UTC. | Duration | read
timeZoneName | The time zone name. | String | read
isUtc | True if this `JDate` is set to UTC time. | bool | read
isLeapYear | True if this `JDate.year` is a leap year. | bool | read
weekdayName | Returns the name of weekDay in persian. | String | read
monthName | Returns the name of month in persian. | String | read
shortYear | Returns the short version of year. | int | read
monthLength | Returns number of days in that month. | int | read


## JDate Instance Methods

Method|Description
------|-----------
changeTo({int year,int month,...,bool isUtc}) | Change a `JDate` instance to specified parameters.
echo(String format) | returns String of `JDate` base on given format. 
toString() | Returns a human-readable string for this instance.
toDateTime() | Converts this `JDate` to a DateTime object with gregorian date.
add(Duration duration) | Returns a new `JDate` instance with `duration` added to `this`.
subtract(Duration duration) | Returns a new `JDate` instance with `duration` subtracted from `this`.
isAtSameMomentAs(JDate other) | Returns true if `this` occurs at the same moment as `other`.
isBefore(JDate other) | Returns true if `this` occurs before `other`.
isAfter(JDate other) | Returns true if `this` occurs after `other`.
Duration difference(JDate other) | Returns a `Duration` with the difference when subtracting `other` from `this`.
compareTo(JDate other) | Compares this `JDate` object to `other`, returning zero if the values are equal.
toIso8601String() | Returns an ISO-8601 full-precision extended format representation.
toUtc() | Returns this `JDate` value in the UTC time zone.
toLocal() | Returns this `JDate` value in the local time zone.

## Static methods

These methods can be used without creating an instance of the object:

Method|Description
------|-----------
parse(String string) | Parse the string an returns a `JDate` object, throws Exception if string is not valid 
tryParse(String string) | Tries to parse the string an returns a `JDate` object, returns null if string is not valid 
jalaliToGregorian(int year, int month, int date) | Converts Jalali date to Gregorian and return the result as a `BasicDate`
gregorianToJalali(int year, int month, int date) | Converts Gregorian date to Jalali and return the result as a `BasicDate`
ummalquraToGregorian(int year, int month, int date) | Converts Ummalqura date to Gregorian and return the result as a `BasicDate`
gregorianToUmmalqura(int year, int month, int date) | Converts Gregorian date to Ummalqura and return the result as a `BasicDate`
ummalquraToJalali(int year, int month, int date) | Converts Jalali date to Ummalqura and return the result as a `BasicDate`
jalaliToUmmalqura(int year, int month, int date) | Converts Ummalqura date to Jalali and return the result as a `BasicDate`
islamicToGregorian(int year, int month, int date) | Converts Islamic date to Gregorian and return the result as a `BasicDate`
gregorianToIslamic(int year, int month, int date) | Converts Gregorian date to Islamic and return the result as a `BasicDate`
islamicToJalali(int year, int month, int date) | Converts Islamic date to Jalali and return the result as a `BasicDate`
jalaliToIslamic(int year, int month, int date) | Converts Jalali date to Islamic and return the result as a `BasicDate`

## Extension Methods

These methods can be used on mentioned objects:

Method|Description
------|-----------
String.numbersToEnglish() | Converts Persian digits in string to english digits
String.numbersToPersian() | Converts English digits in string to Persian digits
int.toPersianWords(bool ordinal) | Returns number as Persian text
DateTime.toJdate() | Creates a JDate base on DateTime gregorian date

## License

jdate_dart is available under the [BSD 3 Clause license](https://opensource.org/licenses/BSD-3-Clause).

## Copyright Notice
The initial version of this library had been written based on [JDate.js](https://github.com/moghaddam24/JDate.js) by [Reza Moghaddam](https://github.com/moghaddam24).  
Date Conversion methods written based on Roozbeh Pournader and Mohammad Toossi work