import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/colors.dart';
import '../widgets/cosmic_chronometer.dart';
import '../widgets/event_detail_sheet.dart';
import '../manager/worship_provider.dart';
import '../../domain/entities/worship_event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showEventDetails(BuildContext context, int day) {
    final provider = Provider.of<WorshipProvider>(context, listen: false);
    
    final event = provider.currentMonthEvents.firstWhere(
      (e) => e.hijriDate.endsWith("-$day"), 
      orElse: () => WorshipEvent()
        ..title = "لا يوجد حدث"
        ..description = "يوم هادئ للذكر والدعاء"
        ..isEnabled = false,
    );

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => EventDetailSheet(
        day: day,
        event: provider.currentMonthEvents.contains(event) ? event : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
          ),
          
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text(
                  "مِيقات",
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: MeeqatColors.spiritualGold,
                    letterSpacing: 2,
                  ),
                ),
                const Text(
                  "دليلك الروحاني في رحلة الزمان",
                  style: TextStyle(color: MeeqatColors.cloudWhite, fontSize: 16, opacity: 0.7),
                ),
                const Spacer(),
                
                Center(
                  child: CosmicChronometer(
                    onDaySelected: (day) => _showEventDetails(context, day),
                  ),
                ),
                
                const Spacer(),
                
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: MeeqatColors.midnightBlue.withOpacity(0.8),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "اليوم في مِيقات",
                        style: TextStyle(color: MeeqatColors.spiritualGold, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Consumer<WorshipProvider>(
                        builder: (context, provider, child) {
                          return const Text(
                            "لا توجد طاعات محددة لهذا اليوم. استثمر وقتك في ذكر الله.",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: MeeqatColors.cloudWhite, fontSize: 14),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
