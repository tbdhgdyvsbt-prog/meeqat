import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/colors.dart';
import 'core/utils/notification_service.dart';
import 'presentation/manager/worship_provider.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/main_navigation.dart';
import 'package:isar/isar.dart';
import 'domain/entities/worship_event.dart';
import 'domain/entities/worship_event.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Isar
  final isar = await Isar.open(
    [WorshipEventSchema], 
    directory: './', 
  );
  
  final notificationService = NotificationService();
  await notificationService.init();

  runApp(
    MultiProvider(
      providers: [
        Provider<Isar>.value(value: isar),
        ChangeNotifierProvider(
          create: (_) => WorshipProvider(isar, notificationService),
        ),
      ],
      child: const MeeqatApp(),
    ),
  );
}

class MeeqatApp extends StatelessWidget {
  const MeeqatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مِيقات - Meeqat',
      debugShowCheckedModeBanner: false,
      theme: MeeqatTheme.darkTheme,
      home: const MainNavigation(),
    );
  }
}
