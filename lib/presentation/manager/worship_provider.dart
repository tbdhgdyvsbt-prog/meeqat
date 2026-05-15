import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:isar/isar.dart';
import '../../domain/entities/worship_event.dart';
import '../../data/repositories/update_service.dart';
import '../../core/utils/notification_service.dart';

class WorshipProvider with ChangeNotifier {
  final Isar isar;
  final NotificationService _notificationService;
  late UpdateService _updateService;

  WorshipProvider(this.isar, this._notificationService) {
    _updateService = UpdateService(isar);
    syncAndSchedule();
  }

  // Current month's events for the UI
  List<WorshipEvent> get currentMonthEvents {
    // Logic to filter events based on current Hijri month
    return isar.worshipEvents.where().findAllSync();
  }

  Future<void> syncAndSchedule() async {
    // 1. Silent sync with server
    await _updateService.syncEvents();
    
    // 2. Schedule notifications for all enabled events
    final events = await isar.worshipEvents.filter().isEnabledEqualTo(true).findAll();
    
    for (var event in events) {
      // Schedule Phase 1: 24h before
      final prepDate = event.gregorianDate.subtract(const Duration(days: 1));
      await _notificationService.scheduleNotification(
        id: event.id * 10, // Unique ID for prep
        title: "استعداد لـ ${event.title}",
        body: "غداً هو موعد ${event.title}. استعد لتجديد النية.",
        scheduledDate: prepDate,
      );

      // Schedule Phase 2: Day of event (morning)
      await _notificationService.scheduleNotification(
        id: event.id, // Unique ID for actual event
        title: "حان موعد ${event.title}",
        body: event.notificationMessage,
        scheduledDate: event.gregorianDate,
      );
    }
    notifyListeners();
  }

  void toggleEvent(WorshipEvent event) {
    isar.writeTxnSync(() {
      event.isEnabled = !event.isEnabled;
      isar.worshipEvents.putSync(event);
    });
    syncAndSchedule(); // Reschedule notifications
    notifyListeners();
  }
}
