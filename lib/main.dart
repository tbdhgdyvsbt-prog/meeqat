import 'package:flutter/material.dart';
import 'core/theme/colors.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MeeqatApp());
}

class MeeqatApp extends StatelessWidget {
  const MeeqatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مِيقات - Meeqat',
      debugShowCheckedModeBanner: false,
      theme: MeeqatTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
