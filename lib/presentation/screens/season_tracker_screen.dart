import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import 'package:intl/intl.dart';

class SeasonEvent {
  final String name;
  final DateTime date;
  final String description;
  final Color color;

  SeasonEvent({
    required this.name,
    required this.date,
    required this.description,
    required this.color,
  });
}

class SeasonTrackerScreen extends StatelessWidget {
  const SeasonTrackerScreen({super.key});

  // Mock data for seasons - in a real app, this comes from the UpdateService/JSON
  List<SeasonEvent> get _seasons => [
    SeasonEvent(
      name: "شهر رمضان المبارك",
      date: DateTime(2026, 2, 18), // Approximate
      description: "شهر الصيام والقيام ومغفرة الذنوب.",
      color: MeeqatColors.spiritualGold,
    ),
    SeasonEvent(
      name: "عشر ذي الحجة",
      date: DateTime(2026, 5, 27), // Approximate
      description: "أفضل أيام الدنيا، فيها يوم عرفة وعيد الأضحى.",
      color: MeeqatColors.softEmerald,
    ),
    SeasonEvent(
      name: "يوم عاشوراء",
      date: DateTime(2026, 7, 26), // Approximate
      description: "يوم نجّى الله فيه موسى عليه السلام.",
      color: MeeqatColors.accentAmber,
    ),
  ];

  int _calculateDaysUntil(DateTime date) {
    return date.difference(DateTime.now()).inDays;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("مفكرة المواسم", style: TextStyle(color: MeeqatColors.spiritualGold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.5,
            colors: [
              Color(0xFF1A2A4A),
              MeeqatColors.midnightBlue,
            ],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: _seasons.length,
          itemBuilder: (context, index) {
            final season = _seasons[index];
            final daysLeft = _calculateDaysUntil(season.date);

            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: MeeqatColors.midnightBlue.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: season.color.withOpacity(0.3)),
                boxShadow: [
                  BoxShadow(
                    color: season.color.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // Countdown Circle
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: season.color.withOpacity(0.2),
                        border: Border.all(color: season.color, width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            daysLeft.toString(),
                            style: TextStyle(
                              color: season.color,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "يوم",
                            style: TextStyle(color: season.color, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Text Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            season.name,
                            style: const TextStyle(
                              color: MeeqatColors.cloudWhite,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            season.description,
                            style: TextStyle(
                              color: MeeqatColors.cloudWhite.withOpacity(0.7),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
