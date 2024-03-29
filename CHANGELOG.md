## 0.9.0
- Migrate to null safety
- Changed `toString` to match DateTime style
- More documents

## 0.8.0

- Renamed Hijri Converters to Ummalqura (Arabic Hijri Qamari)
- Added Islamic (Persian Hijri Qamari) Converters
- Added even more tests 😊

## 0.7.0

- Added a new class `BasicDate`
- Convert functions now return `BasicDate`
- Added more tests!!
- Added more examples
- Added two new operator `>=` and `<=`  

## 0.6.0

- Changed the goal from being friendly with javascript developers to be more compatible with original dart `DateTime` class
- Replaced getter and setters with dart style
- Added `toJdate()` as `DateTime` extension function
- Changed `JDate` to be more like `DateTime` class
- Added more documents
- Added new functions  
- Added more tests!!
- Fixed bugs 


## 0.4.0

- Added `jalaliToHijri`,`hijriToJalali`,`gregorianToHijri` and `hijriToGregorian`
- Added `toPersianWords` function as extension to int 
- Added `getMonthLength`
- Added more tests
- Added some documents
- Fixed `Jdate.parse` method
- Fixed a bug in `echo` function 
- Fixed minor bugs
- Used type instead of var as function inputs 
- Clean up code using dart features
- `withZero` function is now private


## 0.2.0

- Changed `numbersToEnglish` and `numbersToPersian` to String extension functions
- Changed `gregorianToJalali` and `jalaliToGregorian` to static functions
- Fixed minor bugs
- Improved code clarity


## 0.1.0

- Initial version
