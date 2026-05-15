import 'package:flutter/material.dart';
import '../core/theme/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "مِيقات",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: MeeqatColors.spiritualGold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "جاري بناء عالمك الروحاني...",
              style: TextStyle(color: MeeqatColors.cloudWhite, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
