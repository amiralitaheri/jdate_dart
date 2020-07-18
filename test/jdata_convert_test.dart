import 'package:jdate/jdate.dart';
import 'package:test/test.dart';

void main() {
  group('Date Convert', () {
    [
      //edge
      [1000, 01, 01, 0378, 10, 11],
      [2020, 07, 18, 1399, 04, 28],
      [2019, 07, 19, 1398, 04, 28],
      [1998, 06, 18, 1377, 03, 28],
      [2012, 06, 18, 1391, 03, 29],
      [2020, 02, 20, 1398, 12, 01],
      [2020, 07, 16, 1399, 04, 26],
      [2020, 06, 17, 1399, 03, 28],
      [2021, 03, 21, 1400, 01, 01],
      [2035, 07, 05, 1414, 04, 14],
      [2176, 07, 26, 1555, 05, 05],
      [2222, 02, 22, 1600, 12, 03],

      //random from 2000-2020
      [2000, 02, 11, 1378, 11, 22],
      [2003, 10, 16, 1382, 07, 24],
      [2017, 09, 24, 1396, 07, 02],
      [2005, 08, 01, 1384, 05, 10],
      [2013, 02, 16, 1391, 11, 28],
      [2003, 10, 20, 1382, 07, 28],
      [2009, 09, 09, 1388, 06, 18],
      [2002, 08, 22, 1381, 05, 31],
      [2006, 02, 19, 1384, 11, 30],
      [2005, 05, 08, 1384, 02, 18],
      [2001, 08, 29, 1380, 06, 07],
      [2010, 02, 14, 1388, 11, 25],
      [2014, 11, 24, 1393, 09, 03],
      [2009, 11, 24, 1388, 09, 03],
      [2016, 07, 18, 1395, 04, 28],
      [2000, 12, 17, 1379, 09, 27],
      [2017, 07, 12, 1396, 04, 21],
      [2002, 05, 16, 1381, 02, 26],
      [2018, 04, 07, 1397, 01, 18],
      [2016, 05, 08, 1395, 02, 19],
      [2007, 02, 06, 1385, 11, 17],
      [2003, 01, 21, 1381, 11, 01],
      [2017, 10, 14, 1396, 07, 22],
      [2001, 03, 11, 1379, 12, 21],
      [2018, 09, 14, 1397, 06, 23],
      [2012, 04, 21, 1391, 02, 02],
      [2012, 10, 11, 1391, 07, 20],
      [2016, 08, 06, 1395, 05, 16],
      [2001, 03, 22, 1380, 01, 02],
      [2016, 05, 12, 1395, 02, 23],
      [2015, 09, 07, 1394, 06, 16],
      [2013, 11, 26, 1392, 09, 05],
      [2016, 07, 29, 1395, 05, 08],
      [2009, 06, 11, 1388, 03, 21],
      [2012, 02, 13, 1390, 11, 24],
      [2017, 08, 16, 1396, 05, 25],
      [2014, 12, 10, 1393, 09, 19],
      [2020, 05, 30, 1399, 03, 10],
      [2005, 04, 17, 1384, 01, 28],
      [2006, 08, 26, 1385, 06, 04],
      [2005, 04, 29, 1384, 02, 09],
      [2016, 03, 24, 1395, 01, 05],
      [2019, 07, 30, 1398, 05, 08],
      [2015, 12, 14, 1394, 09, 23],
      [2012, 05, 05, 1391, 02, 16],
      [2000, 11, 02, 1379, 08, 12],
      [2009, 08, 06, 1388, 05, 15],
      [2001, 06, 20, 1380, 03, 30],
      [2007, 08, 29, 1386, 06, 07],
      [2015, 02, 15, 1393, 11, 26],
      [2017, 07, 29, 1396, 05, 07],
      [2016, 09, 27, 1395, 07, 06],
      [2012, 02, 23, 1390, 12, 04],
      [2015, 07, 06, 1394, 04, 15],
      [2010, 08, 10, 1389, 05, 19],
      [2001, 11, 06, 1380, 08, 15],
      [2009, 04, 24, 1388, 02, 04],
      [2010, 08, 24, 1389, 06, 02],
      [2001, 08, 23, 1380, 06, 01],
      [2013, 12, 12, 1392, 09, 21],
      [2013, 10, 31, 1392, 08, 09],
      [2005, 01, 18, 1383, 10, 29],
      [2004, 10, 03, 1383, 07, 12],
      [2001, 10, 02, 1380, 07, 10],
      [2018, 01, 25, 1396, 11, 05],
      [2010, 12, 29, 1389, 10, 08],
      [2010, 10, 05, 1389, 07, 13],
      [2013, 08, 11, 1392, 05, 20],
      [2009, 08, 14, 1388, 05, 23],
      [2016, 12, 06, 1395, 09, 16],
      [2004, 12, 14, 1383, 09, 24],
      [2010, 05, 14, 1389, 02, 24],
      [2008, 05, 15, 1387, 02, 26],
      [2019, 08, 23, 1398, 06, 01],
      [2005, 07, 07, 1384, 04, 16],
      [2012, 08, 01, 1391, 05, 11],
      [2010, 06, 14, 1389, 03, 24],
      [2004, 08, 31, 1383, 06, 10],
      [2018, 05, 11, 1397, 02, 21],
      [2007, 12, 29, 1386, 10, 08],
      [2018, 06, 06, 1397, 03, 16],
      [2002, 04, 18, 1381, 01, 29],
      [2006, 08, 02, 1385, 05, 11],
      [2009, 10, 01, 1388, 07, 09],
      [2017, 04, 16, 1396, 01, 27],
      [2001, 08, 13, 1380, 05, 22],
      [2013, 11, 15, 1392, 08, 24],
      [2001, 10, 28, 1380, 08, 06],
      [2017, 12, 20, 1396, 09, 29],
      [2011, 06, 15, 1390, 03, 25],
      [2012, 07, 17, 1391, 04, 27],
      [2015, 07, 17, 1394, 04, 26],
      [2002, 05, 06, 1381, 02, 16],
      [2001, 11, 16, 1380, 08, 25],
      [2018, 07, 25, 1397, 05, 03],
      [2011, 08, 30, 1390, 06, 08],
      [2020, 07, 05, 1399, 04, 15],
      [2006, 12, 31, 1385, 10, 10],
      [2002, 11, 11, 1381, 08, 20],
      [2004, 12, 29, 1383, 10, 09],
      [2020, 08, 10, 1399, 05, 20],
      [2010, 07, 25, 1389, 05, 03],
      [2017, 12, 16, 1396, 09, 25],
      [2000, 08, 17, 1379, 05, 27],
      [2006, 04, 25, 1385, 02, 05],
      [2007, 02, 19, 1385, 11, 30],
      [2010, 12, 16, 1389, 09, 25],
      [2002, 01, 25, 1380, 11, 05],
      [2019, 01, 11, 1397, 10, 21],
      [2016, 02, 13, 1394, 11, 24],
      [2005, 04, 07, 1384, 01, 18],
      [2015, 06, 24, 1394, 04, 03],
      [2012, 10, 17, 1391, 07, 26],
      [2003, 03, 25, 1382, 01, 05],
      [2000, 12, 30, 1379, 10, 10],
      [2007, 04, 23, 1386, 02, 03],
      [2006, 02, 04, 1384, 11, 15],
      [2006, 12, 18, 1385, 09, 27],
      [2011, 09, 08, 1390, 06, 17],
      [2019, 07, 12, 1398, 04, 21],
      [2004, 01, 27, 1382, 11, 07],
      [2010, 07, 10, 1389, 04, 19],
      [2020, 04, 12, 1399, 01, 24],
      [2005, 12, 07, 1384, 09, 16],
      [2004, 07, 26, 1383, 05, 05],
      [2012, 10, 29, 1391, 08, 08],
      [2009, 12, 16, 1388, 09, 25],
      [2018, 02, 18, 1396, 11, 29],
      [2017, 03, 11, 1395, 12, 21],
      [2000, 06, 24, 1379, 04, 04],
      [2004, 05, 08, 1383, 02, 19],
      [2020, 05, 11, 1399, 02, 22],
      [2004, 02, 24, 1382, 12, 05],
      [2001, 10, 31, 1380, 08, 09],
      [2001, 12, 02, 1380, 09, 11],
      [2006, 07, 10, 1385, 04, 19],
      [2006, 09, 02, 1385, 06, 11],
      [2006, 08, 23, 1385, 06, 01],
      [2016, 01, 04, 1394, 10, 14],
      [2001, 06, 18, 1380, 03, 28],
      [2017, 11, 28, 1396, 09, 07],
      [2002, 05, 20, 1381, 02, 30],
      [2012, 09, 12, 1391, 06, 22],
      [2006, 02, 12, 1384, 11, 23],
      [2006, 12, 14, 1385, 09, 23],
      [2007, 10, 08, 1386, 07, 16],
      [2018, 11, 17, 1397, 08, 26],
      [2007, 03, 19, 1385, 12, 28],
      [2000, 12, 19, 1379, 09, 29],
      [2005, 04, 05, 1384, 01, 16],
      [2020, 12, 15, 1399, 09, 25],
      [2011, 03, 30, 1390, 01, 10],
      [2000, 11, 11, 1379, 08, 21],
      [2016, 12, 28, 1395, 10, 08],
      [2005, 09, 01, 1384, 06, 10],
      [2011, 11, 13, 1390, 08, 22],
      [2018, 04, 21, 1397, 02, 01],
      [2014, 11, 27, 1393, 09, 06],
      [2006, 01, 11, 1384, 10, 21],
      [2000, 03, 10, 1378, 12, 20],
      [2016, 12, 30, 1395, 10, 10],
      [2016, 06, 30, 1395, 04, 10],
      [2016, 12, 07, 1395, 09, 17],
      [2019, 07, 10, 1398, 04, 19],
      [2003, 11, 30, 1382, 09, 09],
      [2011, 07, 11, 1390, 04, 20],
      [2006, 07, 05, 1385, 04, 14],
      [2001, 11, 13, 1380, 08, 22],
      [2006, 06, 24, 1385, 04, 03],
      [2004, 07, 11, 1383, 04, 21],
      [2014, 06, 17, 1393, 03, 27],
      [2006, 06, 30, 1385, 04, 09],
      [2006, 07, 20, 1385, 04, 29],
      [2007, 03, 23, 1386, 01, 03],
      [2012, 03, 20, 1391, 01, 01],
      [2014, 02, 07, 1392, 11, 18],
      [2014, 12, 10, 1393, 09, 19],
      [2001, 12, 08, 1380, 09, 17],
      [2018, 09, 02, 1397, 06, 11],
      [2005, 09, 10, 1384, 06, 19],
      [2011, 03, 22, 1390, 01, 02],
      [2004, 04, 03, 1383, 01, 15],
      [2019, 06, 16, 1398, 03, 26],
      [2004, 08, 20, 1383, 05, 30],
      [2017, 04, 10, 1396, 01, 21],
      [2013, 06, 25, 1392, 04, 04],
      [2013, 01, 28, 1391, 11, 09],
      [2018, 05, 24, 1397, 03, 03],
      [2008, 08, 15, 1387, 05, 25],
      [2005, 03, 02, 1383, 12, 12],
      [2011, 09, 29, 1390, 07, 07],
      [2009, 10, 25, 1388, 08, 03],
      [2009, 07, 25, 1388, 05, 03],
      [2014, 04, 06, 1393, 01, 17],
      [2018, 05, 22, 1397, 03, 01],
      [2002, 04, 21, 1381, 02, 01],
      [2011, 03, 31, 1390, 01, 11],
      [2011, 01, 20, 1389, 10, 30],
      [2008, 01, 14, 1386, 10, 24],
      [2015, 07, 29, 1394, 05, 07],
      [2013, 04, 05, 1392, 01, 16],
      [2009, 03, 17, 1387, 12, 27],
      [2007, 07, 20, 1386, 04, 29],
      [2007, 01, 07, 1385, 10, 17],
      [2005, 04, 09, 1384, 01, 20],
      [2003, 04, 25, 1382, 02, 05],
      [2002, 04, 19, 1381, 01, 30],
      [2001, 06, 22, 1380, 04, 01],
      [2010, 11, 10, 1389, 08, 19],
      [2009, 07, 13, 1388, 04, 22],
      [2005, 05, 11, 1384, 02, 21],
      [2003, 10, 11, 1382, 07, 19],
      [2006, 12, 08, 1385, 09, 17],
      [2015, 07, 31, 1394, 05, 09],
      [2016, 09, 07, 1395, 06, 17],
      [2004, 10, 25, 1383, 08, 04],
      [2004, 03, 21, 1383, 01, 02],
      [2001, 03, 31, 1380, 01, 11],
      [2018, 11, 08, 1397, 08, 17],
      [2008, 09, 04, 1387, 06, 14],
      [2011, 10, 04, 1390, 07, 12],
      [2017, 12, 19, 1396, 09, 28],
      [2008, 02, 18, 1386, 11, 29],
      [2009, 11, 30, 1388, 09, 09],
      [2005, 01, 24, 1383, 11, 05],
      [2020, 03, 30, 1399, 01, 11],
      [2012, 06, 19, 1391, 03, 30],
      [2003, 10, 04, 1382, 07, 12],
      [2002, 04, 19, 1381, 01, 30],
      [2014, 10, 08, 1393, 07, 16],
      [2002, 01, 14, 1380, 10, 24],
      [2005, 06, 16, 1384, 03, 26],
      [2017, 02, 23, 1395, 12, 05],
      [2015, 07, 10, 1394, 04, 19],
      [2000, 04, 06, 1379, 01, 18],
      [2000, 01, 17, 1378, 10, 27],
      [2013, 04, 25, 1392, 02, 05],
      [2013, 03, 10, 1391, 12, 20],
      [2010, 02, 21, 1388, 12, 02],
      [2001, 04, 30, 1380, 02, 10],
      [2000, 12, 12, 1379, 09, 22],
      [2009, 09, 07, 1388, 06, 16],
      [2008, 03, 28, 1387, 01, 09],
      [2013, 01, 05, 1391, 10, 16],
      [2016, 10, 15, 1395, 07, 24],
      [2003, 09, 30, 1382, 07, 08],
      [2003, 01, 29, 1381, 11, 09],
      [2013, 01, 27, 1391, 11, 08],
      [2004, 09, 21, 1383, 06, 31],
      [2017, 03, 22, 1396, 01, 02],
      [2006, 10, 02, 1385, 07, 10],
      [2011, 09, 24, 1390, 07, 02],
      [2009, 09, 29, 1388, 07, 07],
      [2007, 04, 03, 1386, 01, 14],
      [2016, 08, 11, 1395, 05, 21],
      [2014, 05, 16, 1393, 02, 26],
      [2005, 03, 22, 1384, 01, 02],
      [2010, 01, 28, 1388, 11, 08],
      [2020, 04, 20, 1399, 02, 01],
      [2013, 07, 21, 1392, 04, 30],
      [2008, 01, 29, 1386, 11, 09],
      [2009, 11, 25, 1388, 09, 04],
      [2018, 01, 26, 1396, 11, 06],
      [2003, 10, 26, 1382, 08, 04],
      [2005, 03, 04, 1383, 12, 14],
      [2003, 02, 15, 1381, 11, 26],
      [2001, 11, 15, 1380, 08, 24],
      [2001, 08, 13, 1380, 05, 22],
      [2020, 04, 28, 1399, 02, 09],
      [2013, 02, 05, 1391, 11, 17],
      [2001, 03, 18, 1379, 12, 28],
      [2001, 05, 15, 1380, 02, 25],
      [2002, 06, 01, 1381, 03, 11],
      [2007, 04, 19, 1386, 01, 30],
      [2006, 05, 28, 1385, 03, 07],
      [2002, 01, 08, 1380, 10, 18],
      [2004, 04, 19, 1383, 01, 31],
      [2012, 02, 10, 1390, 11, 21],
      [2019, 08, 18, 1398, 05, 27],
      [2009, 06, 01, 1388, 03, 11],
      [2000, 11, 23, 1379, 09, 03],
      [2018, 11, 11, 1397, 08, 20],
      [2005, 02, 16, 1383, 11, 28],
      [2009, 03, 01, 1387, 12, 11],
      [2004, 08, 22, 1383, 06, 01],
      [2002, 01, 09, 1380, 10, 19],
      [2000, 09, 03, 1379, 06, 13],
      [2008, 06, 08, 1387, 03, 19],
      [2002, 09, 19, 1381, 06, 28],
      [2017, 10, 07, 1396, 07, 15],
      [2005, 09, 26, 1384, 07, 04],
      [2017, 09, 08, 1396, 06, 17],
      [2005, 03, 08, 1383, 12, 18],
      [2003, 09, 10, 1382, 06, 19],
      [2000, 01, 02, 1378, 10, 12],
      [2002, 08, 14, 1381, 05, 23],
      [2010, 07, 18, 1389, 04, 27],
      [2020, 04, 19, 1399, 01, 31],
      [2019, 08, 27, 1398, 06, 05],
      [2015, 05, 24, 1394, 03, 03],

      //random from 2020-2100
      [2099, 08, 26, 1478, 06, 05],
      [2051, 04, 27, 1430, 02, 07],
      [2022, 06, 27, 1401, 04, 06],
      [2049, 11, 19, 1428, 08, 29],
      [2049, 07, 22, 1428, 05, 01],
      [2027, 05, 11, 1406, 02, 21],
      [2062, 06, 04, 1441, 03, 15],
      [2094, 10, 04, 1473, 07, 13],
      [2095, 11, 06, 1474, 08, 16],
      [2097, 01, 31, 1475, 11, 12],
      [2029, 04, 27, 1408, 02, 08],
      [2031, 01, 30, 1409, 11, 10],
      [2056, 03, 15, 1434, 12, 25],
      [2063, 11, 03, 1442, 08, 12],
      [2081, 12, 27, 1460, 10, 07],
      [2050, 07, 02, 1429, 04, 11],
      [2094, 02, 15, 1472, 11, 27],
      [2079, 02, 24, 1457, 12, 06],
      [2031, 11, 06, 1410, 08, 15],
      [2027, 05, 26, 1406, 03, 05],
      [2084, 11, 03, 1463, 08, 13],
      [2097, 08, 14, 1476, 05, 24],
      [2069, 12, 24, 1448, 10, 04],
      [2091, 03, 15, 1469, 12, 25],
      [2044, 10, 23, 1423, 08, 02],
      [2071, 12, 18, 1450, 09, 27],
      [2095, 02, 11, 1473, 11, 23],
      [2023, 06, 09, 1402, 03, 19],
      [2094, 03, 30, 1473, 01, 11],
      [2075, 05, 31, 1454, 03, 10],
      [2089, 09, 22, 1468, 07, 01],
      [2053, 10, 18, 1432, 07, 27],
      [2051, 11, 20, 1430, 08, 29],
      [2056, 02, 02, 1434, 11, 13],
      [2093, 06, 05, 1472, 03, 16],
      [2094, 02, 21, 1472, 12, 03],
      [2041, 11, 30, 1420, 09, 10],
      [2077, 03, 21, 1456, 01, 02],
      [2063, 07, 21, 1442, 04, 30],
      [2099, 06, 18, 1478, 03, 29],
      [2078, 06, 13, 1457, 03, 24],
      [2042, 08, 15, 1421, 05, 24],
      [2055, 02, 27, 1433, 12, 08],
      [2067, 02, 28, 1445, 12, 10],
      [2030, 06, 03, 1409, 03, 13],
      [2067, 11, 23, 1446, 09, 02],
      [2023, 11, 04, 1402, 08, 13],
      [2026, 07, 01, 1405, 04, 10],
      [2039, 12, 04, 1418, 09, 13],
      [2046, 01, 31, 1424, 11, 12],
      [2098, 03, 20, 1477, 01, 01],
      [2065, 11, 05, 1444, 08, 15],
      [2072, 08, 02, 1451, 05, 12],
      [2064, 08, 10, 1443, 05, 20],
      [2028, 04, 21, 1407, 02, 02],
      [2034, 10, 02, 1413, 07, 10],
      [2031, 05, 05, 1410, 02, 15],
      [2065, 06, 21, 1444, 04, 01],
      [2024, 10, 22, 1403, 08, 01],
      [2080, 02, 28, 1458, 12, 09],
      [2047, 03, 15, 1425, 12, 24],
      [2040, 06, 06, 1419, 03, 17],
      [2028, 08, 25, 1407, 06, 04],
      [2020, 09, 08, 1399, 06, 18],
      [2079, 08, 16, 1458, 05, 25],
      [2078, 07, 23, 1457, 05, 02],
      [2067, 01, 09, 1445, 10, 20],
      [2080, 09, 01, 1459, 06, 11],
      [2093, 07, 03, 1472, 04, 13],
      [2043, 02, 15, 1421, 11, 26],
      [2041, 07, 11, 1420, 04, 21],
      [2020, 02, 26, 1398, 12, 07],
      [2049, 11, 25, 1428, 09, 05],
      [2062, 11, 09, 1441, 08, 19],
      [2092, 09, 29, 1471, 07, 08],
      [2081, 07, 09, 1460, 04, 19],
      [2071, 07, 21, 1450, 04, 30],
      [2062, 05, 22, 1441, 03, 02],
      [2097, 04, 07, 1476, 01, 19],
      [2084, 04, 26, 1463, 02, 07],
      [2077, 07, 21, 1456, 04, 31],
      [2073, 03, 07, 1451, 12, 17],
      [2053, 12, 02, 1432, 09, 12],
      [2073, 01, 20, 1451, 11, 01],
      [2076, 03, 31, 1455, 01, 12],
      [2095, 09, 23, 1474, 07, 02],
      [2061, 12, 08, 1440, 09, 18],
      [2066, 01, 13, 1444, 10, 24],
      [2049, 01, 05, 1427, 10, 16],
      [2091, 08, 20, 1470, 05, 29],
      [2034, 04, 14, 1413, 01, 25],
      [2061, 01, 19, 1439, 10, 30],
      [2067, 10, 14, 1446, 07, 22],
      [2082, 11, 17, 1461, 08, 27],
      [2025, 03, 10, 1403, 12, 20],
      [2026, 08, 13, 1405, 05, 22],
      [2037, 08, 24, 1416, 06, 03],
      [2043, 03, 20, 1421, 12, 29],
      [2055, 08, 31, 1434, 06, 09],
      [2032, 12, 22, 1411, 10, 02],

      //random from 1500-2000
      [1866, 12, 19, 1245, 09, 28],
      [1815, 02, 06, 1193, 11, 17],
      [1678, 10, 25, 1057, 08, 04],
      [1581, 03, 28, 960, 01, 08],
      [1623, 04, 18, 1002, 01, 29],
      [1592, 04, 22, 971, 02, 02],
      [1893, 04, 04, 1272, 01, 15],
      [1748, 08, 19, 1127, 05, 29],
      [1738, 02, 16, 1116, 11, 27],
      [1851, 05, 02, 1230, 02, 12],
      [1869, 08, 15, 1248, 05, 24],
      [1882, 06, 20, 1261, 03, 30],
      [1685, 04, 10, 1064, 01, 22],
      [1994, 02, 26, 1372, 12, 07],
      [1511, 04, 01, 890, 01, 11],
      [1784, 07, 26, 1163, 05, 05],
      [1518, 09, 21, 897, 06, 29],
      [1772, 08, 23, 1151, 06, 02],
      [1617, 03, 30, 996, 01, 10],
      [1814, 05, 22, 1193, 03, 01],
      [1624, 05, 29, 1003, 03, 09],
      [1642, 12, 08, 1021, 09, 17],
      [1993, 10, 15, 1372, 07, 23],
      [1550, 06, 20, 929, 03, 30],
      [1983, 03, 22, 1362, 01, 02],
      [1569, 07, 16, 948, 04, 25],
      [1658, 04, 05, 1037, 01, 16],
      [1685, 08, 31, 1064, 06, 10],
      [1554, 11, 04, 933, 08, 13],
      [1589, 02, 21, 967, 12, 02],
      [1727, 12, 09, 1106, 09, 18],
      [1619, 05, 06, 998, 02, 16],
      [1882, 07, 18, 1261, 04, 27],
      [1961, 08, 12, 1340, 05, 21],
      [1680, 01, 23, 1058, 11, 03],
      [1654, 02, 08, 1032, 11, 20],
      [1889, 10, 11, 1268, 07, 19],
      [1957, 01, 20, 1335, 10, 30],
      [1536, 12, 25, 915, 10, 04],
      [1822, 01, 05, 1200, 10, 15],
      [1849, 09, 27, 1228, 07, 05],
      [1630, 07, 14, 1009, 04, 23],
      [1656, 01, 27, 1034, 11, 07],
      [1903, 01, 29, 1281, 11, 08],
      [1609, 02, 07, 987, 11, 19],
      [1569, 01, 08, 947, 10, 18],
      [1553, 01, 02, 931, 10, 12],
      [1932, 03, 19, 1310, 12, 28],
      [1932, 06, 19, 1311, 03, 29],
      [1546, 05, 13, 925, 02, 23],
      [1897, 10, 19, 1276, 07, 28],
      [1949, 07, 09, 1328, 04, 18],
      [1688, 07, 27, 1067, 05, 06],
      [1710, 06, 07, 1089, 03, 17],
      [1512, 07, 06, 891, 04, 15],
      [1747, 05, 07, 1126, 02, 17],
      [1698, 03, 08, 1076, 12, 18],
      [1630, 06, 24, 1009, 04, 03],
      [1503, 01, 24, 881, 11, 03],
      [1717, 09, 04, 1096, 06, 13],
      [1754, 04, 12, 1133, 01, 23],
      [1582, 09, 07, 961, 06, 16],
      [1845, 11, 27, 1224, 09, 06],
      [1556, 08, 22, 935, 05, 31],
      [1746, 06, 26, 1125, 04, 05],
      [1974, 07, 04, 1353, 04, 13],
      [1930, 04, 16, 1309, 01, 27],
      [1675, 08, 16, 1054, 05, 25],
      [1795, 11, 16, 1174, 08, 25],
      [1536, 03, 05, 914, 12, 14],
      [1891, 11, 13, 1270, 08, 22],
      [1599, 09, 05, 978, 06, 14],
      [1627, 10, 25, 1006, 08, 03],
      [1689, 11, 04, 1068, 08, 14],
      [1940, 12, 26, 1319, 10, 05],
      [1566, 11, 26, 945, 09, 05],
      [1714, 01, 04, 1092, 10, 14],
      [1638, 09, 07, 1017, 06, 16],
      [1755, 03, 29, 1134, 01, 09],
      [1736, 03, 02, 1114, 12, 12],
      [1740, 05, 23, 1119, 03, 03],
      [1585, 12, 01, 964, 09, 10],
      [1808, 05, 19, 1187, 02, 29],
      [1989, 02, 18, 1367, 11, 29],
      [1758, 12, 23, 1137, 10, 02],
      [1953, 08, 16, 1332, 05, 25],
      [1740, 04, 01, 1119, 01, 13],
      [1832, 01, 29, 1210, 11, 09],
      [1698, 06, 17, 1077, 03, 28],
      [1635, 03, 01, 1013, 12, 10],
      [1905, 10, 03, 1284, 07, 11],
      [1938, 02, 03, 1316, 11, 14],
      [1508, 10, 12, 887, 07, 20],
      [1753, 11, 06, 1132, 08, 15],
      [1603, 03, 25, 982, 01, 05],
      [1558, 01, 09, 936, 10, 19],
      [1589, 02, 08, 967, 11, 19],
      [1668, 06, 20, 1047, 03, 31],
      [1852, 11, 18, 1231, 08, 27],
      [1580, 04, 26, 959, 02, 06],
      [1788, 11, 08, 1167, 08, 18],
      [1864, 05, 17, 1243, 02, 28],
      [1795, 04, 28, 1174, 02, 08],
      [1562, 11, 16, 941, 08, 25],
      [1983, 05, 25, 1362, 03, 04],
      [1778, 04, 05, 1157, 01, 16],
      [1906, 01, 09, 1284, 10, 19],
      [1744, 11, 20, 1123, 08, 30],
      [1989, 02, 20, 1367, 12, 01],
      [1602, 12, 29, 981, 10, 08],
      [1693, 09, 14, 1072, 06, 24],
      [1765, 08, 30, 1144, 06, 09],
      [1845, 10, 19, 1224, 07, 27],
      [1845, 09, 28, 1224, 07, 06],
      [1800, 09, 13, 1179, 06, 22],
      [1507, 09, 25, 886, 07, 02],
      [1759, 03, 08, 1137, 12, 17],
      [1892, 04, 08, 1271, 01, 20],
      [1881, 03, 27, 1260, 01, 07],
      [1905, 10, 06, 1284, 07, 14],
      [1652, 05, 09, 1031, 02, 20],
      [1739, 07, 08, 1118, 04, 17],
      [1740, 04, 22, 1119, 02, 03],
      [1689, 12, 19, 1068, 09, 29],
      [1654, 02, 17, 1032, 11, 29],
      [1914, 09, 04, 1293, 06, 12],
      [1796, 04, 05, 1175, 01, 17],
      [1766, 03, 26, 1145, 01, 06],
      [1738, 12, 20, 1117, 09, 29],
      [1780, 11, 12, 1159, 08, 22],
      [1901, 11, 22, 1280, 09, 01],
      [1540, 10, 13, 919, 07, 21],
      [1995, 10, 18, 1374, 07, 26],
      [1600, 12, 01, 979, 09, 11],
      [1880, 10, 06, 1259, 07, 15],
      [1685, 06, 20, 1064, 03, 31],
      [1644, 08, 12, 1023, 05, 22],
      [1755, 04, 22, 1134, 02, 02],
      [1645, 06, 14, 1024, 03, 25],
      [1851, 10, 13, 1230, 07, 21],
      [1624, 10, 12, 1003, 07, 21],
      [1598, 08, 05, 977, 05, 14],
      [1828, 02, 02, 1206, 11, 12],
      [1776, 04, 16, 1155, 01, 28],
      [1688, 11, 28, 1067, 09, 08],
      [1650, 09, 04, 1029, 06, 13],
      [1867, 08, 18, 1246, 05, 27],
      [1710, 03, 03, 1088, 12, 12],
      [1871, 03, 09, 1249, 12, 18],
      [1820, 07, 30, 1199, 05, 08],
      [1783, 07, 04, 1162, 04, 13],
      [1882, 03, 23, 1261, 01, 03],
      [1766, 11, 04, 1145, 08, 13],
      [1814, 12, 05, 1193, 09, 14],
      [1653, 12, 29, 1032, 10, 09],
      [1682, 05, 09, 1061, 02, 20],
      [1575, 07, 14, 954, 04, 23],
      [1612, 01, 10, 990, 10, 20],
      [1716, 04, 15, 1095, 01, 26],
      [1987, 09, 04, 1366, 06, 13],
      [1975, 10, 18, 1354, 07, 26],
      [1860, 08, 16, 1239, 05, 25],
      [1991, 04, 03, 1370, 01, 14],
      [1646, 03, 01, 1024, 12, 11],
      [1948, 04, 07, 1327, 01, 18],
      [1959, 10, 20, 1338, 07, 27],
      [1755, 09, 26, 1134, 07, 04],
      [1754, 02, 18, 1132, 11, 29],
      [1716, 02, 21, 1094, 12, 02],
      [1959, 07, 09, 1338, 04, 17],
      [1620, 03, 20, 999, 01, 01],
      [1556, 05, 06, 935, 02, 16],
      [1908, 07, 25, 1287, 05, 03],
      [1844, 01, 24, 1222, 11, 04],
      [1841, 01, 25, 1219, 11, 05],
      [1840, 08, 04, 1219, 05, 13],
      [1735, 09, 07, 1114, 06, 16],
      [1869, 05, 07, 1248, 02, 17],
      [1666, 05, 16, 1045, 02, 27],
      [1630, 09, 10, 1009, 06, 19],
      [1886, 10, 02, 1265, 07, 10],
      [1819, 11, 03, 1198, 08, 11],
      [1637, 10, 19, 1016, 07, 28],
      [1968, 06, 25, 1347, 04, 04],
      [1706, 06, 03, 1085, 03, 13],
      [1818, 05, 18, 1197, 02, 28],
      [1999, 04, 20, 1378, 01, 31],
      [1708, 02, 23, 1086, 12, 04],
      [1520, 02, 12, 898, 11, 22],
      [1537, 04, 28, 916, 02, 08],
      [1995, 01, 27, 1373, 11, 07],
      [1772, 07, 07, 1151, 04, 17],
      [1641, 12, 31, 1020, 10, 11],
      [1794, 07, 14, 1173, 04, 23],
      [1713, 05, 01, 1092, 02, 11],
      [1601, 07, 08, 980, 04, 17],
      [1875, 12, 08, 1254, 09, 17],
      [1801, 09, 05, 1180, 06, 14],
      [1594, 02, 07, 972, 11, 18],
      [1775, 09, 20, 1154, 06, 29],
    ].forEach((date) {
      test('${date[0]}-${date[1]}-${date[2]} to Jalali', () {
        expect(
          JDate.gregorianToJalali(date[0], date[1], date[2]),
          {'year': date[3], 'month': date[4], 'day': date[5]},
        );
      });

      test('${date[3]}-${date[4]}-${date[5]} to Gregorian', () {
        expect(
          JDate.jalaliToGregorian(date[3], date[4], date[5]),
          {'year': date[0], 'month': date[1], 'day': date[2]},
        );
      });
    });
  });
}