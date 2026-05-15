import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import '../../domain/entities/worship_event.dart';

class UpdateService {
  final Isar isar;
  static const String updateUrl = "https://raw.githubusercontent.com/tbdhgdyvsbt-prog/meeqat-data/main/events.json";

  UpdateService(this.isar);

  /// Performs a silent update of the worship events
  Future<void> syncEvents() async {
    try {
      final response = await http.get(Uri.parse(updateUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        
        await isar.writeTxn(() async {
          for (var item in data) {
            final event = WorshipEvent()
              ..eventId = item['id']
              ..title = item['title']
              ..description = item['description']
              ..notificationMessage = item['notification']
              ..hijriDate = item['hijriDate']
              ..gregorianDate = DateTime.parse(item['gregorianDate'])
              ..type = item['type']
              ..isEnabled = true;

            // Update if exists, otherwise add
            final existing = await isar.worshipEvents.filter().eventIdEqualTo(event.eventId).findFirst();
            if (existing != null) {
              existing.title = event.title;
              existing.description = event.description;
              existing.gregorianDate = event.gregorianDate;
              // Keep user's isEnabled preference
              await isar.worshipEvents.put(existing);
            } else {
              await isar.worshipEvents.put(event);
            }
          }
        });
        print("Meeqat Sync: Events updated successfully.");
      }
    } catch (e) {
      print("Meeqat Sync Error: $e");
    }
  }
}
