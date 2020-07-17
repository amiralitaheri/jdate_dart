<p align="center">
    <img src="https://github.com/moghaddam24/JDate.js/blob/master/examples/logo.png?raw=true" alt="logo"><br/>
    Simple yet flexible Dart Jalali date and time for developers
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

<table width="100%">
    <thead>
    <tr>
        <td width="72">Character</td>
        <td>Description</td>
        <td>Range</td>
        <td>Example</td>
    </tr>
    </thead>
    <tbody>
    <tr><td>a</td><td>Before noon and afternoon</td><td>ق.ظ - ب.ظ</td><td>ق.ظ</td></tr>
    <tr><td>b</td><td>Numeric representation of a season, without leading zeros</td><td>0-3</td><td>1</td></tr>
    <tr><td>d</td><td>Day of the month, 2 digits with leading zeros</td><td>01-31</td><td>13</td></tr>
    <tr><td>f</td><td>Season name</td><td>بهار-زمستان</td><td>بهار</td></tr>
    <tr><td>g</td><td>12-hour format of an hour without leading zeros</td><td>0-12</td><td>11</td></tr>
    <tr><td>h</td><td>12-hour format of an hour with leading zeros</td><td>00-12</td><td>03</td></tr>
    <tr><td>i</td><td>Minutes with leading zeros</td><td>00-59</td><td>13</td></tr>
    <tr><td>j</td><td>Day of the month without leading zeros</td><td>1-31</td><td>4</td></tr>
    <tr><td>l</td><td>A full textual representation of the day of the week</td><td>شنبه-جمعه</td><td>یکشنبه</td></tr>
    <tr><td>m</td><td>Numeric representation of a month, with leading zeros</td><td>01-12</td><td>02</td></tr>
    <tr><td>n</td><td>Numeric representation of a month, without leading zeros</td><td>1-12</td><td>2</td></tr>
    <tr><td>s</td><td>Seconds, with leading zeros</td><td>00-59</td><td>03</td></tr>
    <tr><td>t</td><td>Number of days in the given month</td><td>0-31</td><td>28</td></tr>
    <tr><td>u</td><td>Millisecond</td><td>000000</td><td>28</td></tr>
    <tr><td>v</td><td>Short year display in letters</td><td>یک-نهصد و نود و نه</td><td>نود و هشت | چهارصد و دو</td></tr>
    <tr><td>w</td><td>Numeric representation of the day of the week</td><td>0-6</td><td>6</td></tr>
    <tr><td>y</td><td>A two or three digit representation of a year</td><td>1-999</td><td>98 | 402</td></tr>
    <tr><td>A</td><td>Before noon and afternoon</td><td>بعد از ظهر - قبل از ظهر</td><td>قبل از ظهر</td></tr>
    <tr><td>D</td><td>Persian ordinal suffix for the day of the month, 2 characters</td><td>شن‍ - جم‍</td><td>سه</td></tr>
    <tr><td>F</td><td>A full textual representation of a month</td><td>فروردین - اسفند</td><td>اردیبهشت</td></tr>
    <tr><td>G</td><td>24-hour format of an hour without leading zeros</td><td>0-24</td><td>3</td></tr>
    <tr><td>H</td><td>24-hour format of an hour with leading zeros</td><td>00-24</td><td>03</td></tr>
    <tr><td>J</td><td>Day of the month</td><td>یک-سی و یک</td><td>سیزده</td></tr>
    <tr><td>L</td><td>Whether it’s a leap year</td><td>0-1</td><td>1</td></tr>
    <tr><td>M</td><td>A short textual representation of a month, two letters</td><td>فر-اس‍</td><td>ار</td></tr>
    <tr><td>O</td><td>Difference to Greenwich time (GMT) in hours</td><td>-1200 - +1400</td><td>+0330</td></tr>
    <tr><td>V</td><td>Full year display in letters</td><td>صفر-...</td><td>یک هزار و سیصد و نود و هشت</td></tr>
    <tr><td>Y</td><td>A full numeric representation of a year, 4 digits</td><td>0-...</td><td>1398</td></tr>
    </tbody>
</table>


## JDate.parse(...)

You can parse specified shamsi or gregorian date from valid date string to convert it to milliseconds.

    JDate.parse('1399');                    ~~> 1584649800000 ~~> 1399/01/01 - 00:00:00
    JDate.parse('1399/02');                 ~~> 1587324600000 ~~> 1399/02/01 - 00:00:00
    JDate.parse('1399/02/13');              ~~> 1588361400000 ~~> 1399/02/13 - 00:00:00
    JDate.parse('1399/02/13 03:14:30');     ~~> 1588373070000 ~~> 1399/02/13 - 03:14:30
    JDate.parse('2019/05/03 01:02:03');     ~~> 1556829123000 ~~> 1398/02/13 - 01:02:03


## Get JDate Methods

These methods can be used for getting information from a jalali date object:

Method|Description
------|-----------
getDate() | Get the day as a number (1-31)
getDay() | Get the weekday as a number (0-6)
getFullYear() | Get the year as a four digit number (yyyy)
getShortYear() | Get the year as a two or three digit number (yy | yyy)
getHours() | Get the hour (0-23)
getMilliseconds() | Get the millisecond (0-999)
getMinutes() | Get the minute (0-59)
getMonth() | Get the month as a number (0-11)
getSeconds() | Get the second (0-59)
getTime() | Get the time (milliseconds)
getTimezone() | Difference to Greenwich time (GMT) in hours
getTimezoneOffset() |Difference between UTC and Local Time 
isLeapYear() | Whether it’s a leap year (0-1)

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

## extension methods

These methods can be used on mentioned objects:

Method|Description
------|-----------
String.numbersToEnglish() | Converts Persian digits in string to english digits
String.numbersToPersian() | Converts English digits in string to Persian digits
Int.toPersianWords([ordinal = false]) | Returns number as Persian text

## License

jdate_dart is available under the [BSD 3 Clause license](https://opensource.org/licenses/BSD-3-Clause).

## Copyright Notice
The initial version of this library had been written based on [JDate.js](https://github.com/moghaddam24/JDate.js) by [Reza Moghaddam](https://github.com/moghaddam24).  
Date Conversion methods based on Roozbeh Pournader and Mohammad Toossi work