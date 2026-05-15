import 'package:flutter/material.dart';
import '../core/theme/colors.dart';
import '../widgets/cosmic_chronometer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
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
                
                // The Cosmic Chronometer
                Center(
                  child: CosmicChronometer(
                    onDaySelected: (day) {
                      // Future: Show a bottom sheet with the event details
                      print("Selected Day: $day");
                    },
                  ),
                ),
                
                const Spacer(),
                
                // Bottom status area
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
                      const Text(
                        "لا توجد طاعات محددة لهذا اليوم. استثمر وقتك في ذكر الله.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: MeeqatColors.cloudWhite, fontSize: 14),
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
