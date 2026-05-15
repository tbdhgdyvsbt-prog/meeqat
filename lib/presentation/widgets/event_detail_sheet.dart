import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/worship_event.dart';
import '../../presentation/manager/worship_provider.dart';
import '../../core/theme/colors.dart';

class EventDetailSheet extends StatelessWidget {
  final WorshipEvent? event;
  final int day;

  const EventDetailSheet({super.key, this.event, required this.day});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WorshipProvider>(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: MeeqatColors.midnightBlue,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        border: Border(top: BorderSide(color: MeeqatColors.spiritualGold.withOpacity(0.3))),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: MeeqatColors.mutedSlate,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "اليوم $day من الشهر",
            style: const TextStyle(color: MeeqatColors.cloudWhite, fontSize: 16),
          ),
          const SizedBox(height: 12),
          if (event != null) ...[
            Text(
              event?.title ?? "بدون عنوان",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: MeeqatColors.spiritualGold,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              event?.description ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(color: MeeqatColors.cloudWhite, fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "تفعيل التنبيهات",
                  style: TextStyle(color: MeeqatColors.cloudWhite, fontSize: 16),
                ),
                Switch(
                  value: event?.isEnabled ?? false,
                  onChanged: (value) {
                    if (event != null) {
                      provider.toggleEvent(event);
                    }
                  },
                  activeColor: MeeqatColors.spiritualGold,
                ),
              ],
            ),
          ] else ...[
            const SizedBox(height: 20),
            const Text(
              "لا توجد طاعات محددة لهذا اليوم. اجعل يومك مليئاً بذكر الله.",
              textAlign: TextAlign.center,
              style: TextStyle(color: MeeqatColors.mutedSlate, fontSize: 16),
            ),
          ],
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
