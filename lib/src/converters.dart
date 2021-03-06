import 'package:jdate/src/basic_date.dart';

import 'consts.dart';

int _ummalquraDataIndex(int index) {
  if (index < 0 || index >= ummAlquraDateArray.length) {
    throw ArgumentError(
        'Valid date should be between 1356 AH (14 March 1937 CE) to 1500 AH (16 November 2077 CE)');
  }
  return ummAlquraDateArray[index];
}

/// Jalali to Gregorian Conversion
/// Copyright (C) 2000  Roozbeh Pournader and Mohammad Toossi
BasicDate jalaliToGregorian(int jy, int jm, int jd) {
  jy -= 979;
  jm -= 1;
  jd -= 1;
  const gDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  const jDaysInMonth = [31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29];

  var jDayNo = 365 * jy + (jy / 33).floor() * 8 + ((jy % 33 + 3) / 4).floor();
  for (var i = 0; i < jm; ++i) {
    jDayNo += jDaysInMonth[i];
  }

  jDayNo += jd;

  var gDayNo = jDayNo + 79;

  var gy = 1600 + 400 * (gDayNo / 146097).floor();
  gDayNo = gDayNo % 146097;

  var leap = true;
  if (gDayNo >= 36525) {
    gDayNo--;
    gy += 100 * (gDayNo / 36524).floor();
    gDayNo = gDayNo % 36524;

    if (gDayNo >= 365) {
      gDayNo++;
    } else {
      leap = false;
    }
  }

  gy += 4 * (gDayNo / 1461).floor();
  gDayNo %= 1461;

  if (gDayNo >= 366) {
    leap = false;

    gDayNo--;
    gy += (gDayNo / 365).floor();
    gDayNo = gDayNo % 365;
  }
  var i;
  for (i = 0; gDayNo >= gDaysInMonth[i] + ((i == 1 && leap) ? 1 : 0); i++) {
    gDayNo -= gDaysInMonth[i] + ((i == 1 && leap) ? 1 : 0);
  }
  var gm = i + 1;
  var gd = gDayNo + 1;

  return BasicDate(gy, gm, gd);
}

/// Gregorian to Jalali Conversion
/// Copyright (C) 2000  Roozbeh Pournader and Mohammad Toossi
BasicDate gregorianToJalali(int gy, int gm, int gd) {
  gy -= 1600;
  gm -= 1;
  gd -= 1;

  const gDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  const jDaysInMonth = [31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29];

  var gDayNo = 365 * gy +
      ((gy + 3) / 4).floor() -
      ((gy + 99) / 100).floor() +
      ((gy + 399) / 400).floor();

  for (var i = 0; i < gm; ++i) {
    gDayNo += gDaysInMonth[i];
  }
  if (gm > 1 && ((gy % 4 == 0 && gy % 100 != 0) || (gy % 400 == 0))) gDayNo++;
  gDayNo += gd;

  var jDayNo = gDayNo - 79;

  var jNp = (jDayNo / 12053).floor();
  jDayNo = jDayNo % 12053;

  var jy = 979 + 33 * jNp + 4 * (jDayNo / 1461).floor();

  jDayNo %= 1461;

  if (jDayNo >= 366) {
    jy += ((jDayNo - 1) / 365).floor();
    jDayNo = (jDayNo - 1) % 365;
  }
  var i = 0;
  for (i; i < 11 && jDayNo >= jDaysInMonth[i]; ++i) {
    jDayNo -= jDaysInMonth[i];
  }
  var jm = i + 1;
  var jd = jDayNo + 1;
  return BasicDate(jy, jm, jd);
}

BasicDate ummalquraToGregorian(int hy, int hm, int hd) {
  var i = ((hy - 1) * 12) + 1 + (hm - 1) - 16260;
  var julianDate = hd + _ummalquraDataIndex(i - 1) - 1 + 2400000;
  var z = (julianDate + 0.5).floor();
  var a = ((z - 1867216.25) / 36524.25).floor();
  a = z + 1 + a - (a / 4).floor();
  var b = a + 1524;
  var c = ((b - 122.1) / 365.25).floor();
  var d = (365.25 * c).floor();
  var e = ((b - d) / 30.6001).floor();
  var day = b - d - (e * 30.6001).floor();
  var month = e - (e > 13.5 ? 13 : 1);
  var year = c - (month > 2.5 ? 4716 : 4715);
  if (year <= 0) {
    year--;
  }
  return BasicDate(year, month, day);
}

BasicDate gregorianToUmmalqura(int year, int month, int day) {
//This code the modified version of R.H. van Gent Code, it can be found at http://www.staff.science.uu.nl/~gent0113/islam/ummalqura.htm
  var m = month;
  var y = year;

// append January and February to the previous year (i.e. regard March as
// the first month of the year in order to simplify leapday corrections)
  if (m < 3) {
    y -= 1;
    m += 12;
  }

// determine offset between Julian and Gregorian calendar
  var a = (y / 100).floor();
  var jgc = a - (a / 4.0).floor() - 2;

// compute Chronological Julian Day Number (CJDN)
  var cjdn = (365.25 * (y + 4716)).floor() +
      (30.6001 * (m + 1)).floor() +
      day -
      jgc -
      1524;

  a = ((cjdn - 1867216.25) / 36524.25).floor();
  jgc = a - (a / 4.0).floor() + 1;
  var b = cjdn + jgc + 1524;
  var c = ((b - 122.1) / 365.25).floor();
  var d = (365.25 * c).floor();
  month = ((b - d) / 30.6001).floor();
  day = (b - d) - (30.6001 * month).floor();

  if (month > 13) {
    c += 1;
    month -= 12;
  }

  month -= 1;
  year = c - 4716;

// compute Modified Chronological Julian Day Number (MCJDN)
  var mcjdn = cjdn - 2400000;

// the MCJDN's of the start of the lunations in the Umm al-Qura calendar are stored in 'islamcalendar_dat.js'
  var i;
  for (i = 0; i < ummAlquraDateArray.length; i++) {
    if (_ummalquraDataIndex(i) > mcjdn) break;
  }

// compute and output the Umm al-Qura calendar date
  var iln = i + 16260;
  var ii = ((iln - 1) / 12).floor();
  var iy = ii + 1;
  var im = iln - 12 * ii;
  var id = mcjdn - _ummalquraDataIndex(i - 1) + 1;

  return BasicDate(iy, im, id);
}

int islamicToJdn(int year, int month, int day) {
  if (year <= 0) ++year;
  return ((10631 * year - 10617) / 30).floor() +
      ((325 * month - 320) / 11).floor() +
      day +
      1948439;
}

BasicDate jdnToIslamic(int jd) {
  final k2 = 30 * (jd - 1948440) + 15;
  final k1 = 11 * ((k2 % 10631) / 30).floor() + 5;
  var effective_year = (k2 / 10631).floor() + 1;
  if (effective_year <= 0) --effective_year;
  return BasicDate(
      effective_year, (k1 / 325).floor() + 1, ((k1 % 325) / 11).floor() + 1);
}

int gregorianToJdn(int year, int month, int day) {
// append January and February to the previous year (i.e. regard March as
// the first month of the year in order to simplify leapday corrections)
  if (month < 3) {
    year -= 1;
    month += 12;
  }
// determine offset between Julian and Gregorian calendar
  var a = (year / 100).floor();
  var jgc = a - (a / 4.0).floor() - 2;
// compute Chronological Julian Day Number (CJDN)
  return (365.25 * (year + 4716)).floor() +
      (30.6001 * (month + 1)).floor() +
      day -
      jgc -
      1524;
}

BasicDate jdnToGregorian(int jd) {
  final x3Quot = ((4 * jd - 6884477) / 146097).floor();
  final x3Rem = ((4 * jd - 6884477) % 146097);
  final x2Quot = ((100 * (x3Rem / 4).floor() + 99) / 36525).floor();
  final x2Rem = ((100 * (x3Rem / 4).floor() + 99) % 36525);
  final x1Quot = ((5 * (x2Rem / 100).floor() + 2) / 153).floor();
  final x1Rem = ((5 * (x2Rem / 100).floor() + 2) % 153);
  final c0 = ((x1Quot + 2) / 12).floor();
  return BasicDate(100 * x3Quot + x2Quot + c0, x1Quot - 12 * c0 + 3,
      (x1Rem / 5).floor() + 1);
}

BasicDate gregorianToIslamic(int year, int month, int day) =>
    jdnToIslamic(gregorianToJdn(year, month, day));

BasicDate islamicToGregorian(int year, int month, int day) =>
    jdnToGregorian(islamicToJdn(year, month, day));
