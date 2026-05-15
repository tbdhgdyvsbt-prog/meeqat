import 'package:isar/isar.dart';

@collection
class WorshipEvent {
  Id id = Isar.autoIncrement;

  @Index()
  late String eventId; // Unique ID (e.g., "ramadan_start")
  
  late String title;
  late String description;
  late String notificationMessage;
  
  // Dates are stored as strings or timestamps
  late String hijriDate; // Format: "YYYY-MM-DD"
  late DateTime gregorianDate;
  
  late bool isMandatory; // Whether it's a fixed event or optional
  late bool isEnabled; // User customization: enable/disable this alert
  
  // Type of event: "Seasonal", "Weekly", "Lunar", "Astronomical"
  late String type; 
}
