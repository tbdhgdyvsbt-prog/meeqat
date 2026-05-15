import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

class HijriHelper {
  /// Returns the current Hijri date as a formatted string
  static String getCurrentHijriDate() {
    var today = HijriCalendar.now();
    return "${today.year}-${today.month}-${today.day}";
  }

  /// Checks if today is Monday or Thursday
  static bool isWeeklyFastingDay() {
    var now = DateTime.now();
    return now.weekday == DateTime.monday || now.weekday == DateTime.thursday;
  }

  /// Checks if today is one of the "White Days" (13, 14, 15 of Hijri month)
  static bool isWhiteDay() {
    var today = HijriCalendar.now();
    return today.day >= 13 && today.day <= 15;
  }

  /// Calculates the remaining days until a specific Hijri date
  static int daysUntil(int targetYear, int targetMonth, int targetDay) {
    var target = HijriCalendar.setText("${targetYear}/${targetMonth}/${targetDay}");
    var today = HijriCalendar.now();
    
    // Simple difference calculation
    // In a real app, we'd convert both to Gregorian and find the difference in days
    return target.gregorianDate.difference(today.gregorianDate).inDays;
  }
}
