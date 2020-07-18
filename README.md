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

## new JDate()

new JDate() creates a new jalali date object with the current date and time:

    var jd = JDate();
    print(jd);
    
    ~~>    پنج‌شنبه، 15 اسفند 1398 ساعت 20:44:58

## new JDate(year, month, ...)

new JDate(year, month, ...) creates a new jalali date object with a specified date and time.
7 numbers specify year, month, day, hour, minute, second, and millisecond (in that order):

     JDate()                         ~~> پنج‌شنبه، 15 اسفند 1398 ساعت 20:44:58
     JDate(2019)                     ~~> سه‌شنبه، 11 دی 1397 ساعت 00:00:00
     JDate(2019, 4)                  ~~> چهارشنبه، 11 اردیبهشت 1398 ساعت 00:00:00
     JDate(2019, 4, 3)               ~~> جمعه، 13 اردیبهشت 1398 ساعت 00:00:00
     JDate(2019, 4, 3, 10)           ~~> جمعه، 13 اردیبهشت 1398 ساعت 10:00:00
     JDate(2019, 4, 3, 10, 33)       ~~> جمعه، 13 اردیبهشت 1398 ساعت 10:33:00
     JDate(2019, 4, 3, 10, 33, 30)   ~~> جمعه، 13 اردیبهشت 1398 ساعت 10:33:30

## new JDate(year, month, ...) with shamsi date parameters

You can creates a new jalali date object with a specified shamsi date and time.

     JDate()                         ~~> پنج‌شنبه، 15 اسفند 1398 ساعت 20:44:58
     JDate(1398)                     ~~> پنج‌شنبه، 01 فروردین 1398 ساعت 00:00:00
     JDate(1398, 1)                  ~~> یکشنبه، 01 اردیبهشت 1398 ساعت 00:00:00
     JDate(1398, 1, 13)              ~~> جمعه، 13 اردیبهشت 1398 ساعت 00:00:00
     JDate(1398, 1, 13, 3)           ~~> جمعه، 13 اردیبهشت 1398 ساعت 03:00:00
     JDate(1398, 1, 13, 3, 14)       ~~> جمعه، 13 اردیبهشت 1398 ساعت 03:14:00
     JDate(1398, 1, 13, 3, 14, 30)   ~~> جمعه، 13 اردیبهشت 1398 ساعت 03:14:30

## new JDate(...).echo

    var jd = JDate(2019, 4, 3, 10, 33, 30, 0);
    print(jd.echo('l، d F Y ساعت H:i:s'));
    
    ~~>     جمعه، 13 اردیبهشت 1398 ساعت 10:33:30

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

You can parse specified shamsi or gregorian date from valid date string to convert it to JDate object.

    print(JDate.parse('۱۳۹۹/۰۹/۰۹'));              ~~> جمعه، 09 آذر 1399 ساعت 00:00:00
    print(JDate.parse('1399/02/13'));              ~~> پنج‌شنبه، 13 اردیبهشت 1399 ساعت 00:00:00
    print(JDate.parse('1399/02/13 03:14:30'));     ~~> پنج‌شنبه، 13 اردیبهشت 1399 ساعت 03:14:30
    print(JDate.parse('2019/05/03 01:02:03'));     ~~> چهارشنبه، 13 اردیبهشت 1398 ساعت 01:02:03


## Get JDate Methods

These methods can be used for getting information from a jalali date object:

Method|Description
------|-----------
getDate() | Get the day as a number (1-31)
getDay() | Get the weekday as a number (0-6)
getFullYear() | Get the year as a four digit number (yyyy)
getShortYear() | Get the year as a two or three digit number (yy \| yyy)
getHours() | Get the hour (0-23)
getMilliseconds() | Get the millisecond (0-999)
getMinutes() | Get the minute (0-59)
getMonth() | Get the month as a number (0-11)
getSeconds() | Get the second (0-59)
getTime() | Get the time (milliseconds)
getTimezone() | Difference to Greenwich time (GMT) in hours
getTimezoneOffset() |Difference between UTC and Local Time 
isLeapYear() | Whether it’s a leap year (true \| false) 
getMonthLength() | Get number of days in that month (29 \| 30 \| 31)

## Set JDate Methods

These methods can be used for set date values (years, months, days, hours, minutes, seconds, milliseconds) for a jalali date object:

Method|Description
------|-----------
setDate(date) | Set the day as a number (1-31)
setMonth(month, date) | Set the month (0-11)
setFullYear(year, month, date) | Set the year (optionally month and day)
setHours(hours, min, sec, ms) | Set the hour (0-23)
setMilliseconds(ms) | Set the milliseconds (0-999)
setMinutes(min, sec, ms) | Set the minutes (0-59)
setSeconds(sec, ms) | Set the seconds (0-59)
setTime(ms) | Set the time (milliseconds)


## Static methods

These methods can be used without creating an instance of the object:

Method|Description
------|-----------
jalaliToGregorian(year, month, date) | Converts Jalali date to Gregorian and return the result as a map
gregorianToJalali(year, month, date) | Converts Gregorian date to Jalali and return the result as a map
hijriToGregorian(year, month, date) | Converts Hijri date to Gregorian and return the result as a map
gregorianToHijri(year, month, date) | Converts Gregorian date to Hijri and return the result as a map
jalaliToHijri(year, month, date) | Converts Jalali date to Hijri and return the result as a map
hijriToJalali(year, month, date) | Converts Hijri date to Jalali and return the result as a map

## extension methods

These methods can be used on mentioned objects:

Method|Description
------|-----------
String.numbersToEnglish() | Converts Persian digits in string to english digits
String.numbersToPersian() | Converts English digits in string to Persian digits
Int.toPersianWords(bool ordinal) | Returns number as Persian text

## License

jdate_dart is available under the [BSD 3 Clause license](https://opensource.org/licenses/BSD-3-Clause).

## Copyright Notice
The initial version of this library had been written based on [JDate.js](https://github.com/moghaddam24/JDate.js) by [Reza Moghaddam](https://github.com/moghaddam24).  
Date Conversion methods written based on Roozbeh Pournader and Mohammad Toossi work