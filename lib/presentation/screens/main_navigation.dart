import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/colors.dart';
import '../widgets/cosmic_chronometer.dart';
import '../widgets/event_detail_sheet.dart';
import '../manager/worship_provider.dart';
import 'home_screen.dart';
import 'season_tracker_screen.dart';
import '../../domain/entities/worship_event.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const SeasonTrackerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: MeeqatColors.midnightBlue,
        selectedItemColor: MeeqatColors.spiritualGold,
        unselectedItemColor: MeeqatColors.mutedSlate,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome),
            label: "الرادار",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "المواسم",
          ),
        ],
      ),
    );
  }
}
