import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/colors.dart';
import 'core/utils/notification_service.dart';
import 'presentation/manager/worship_provider.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/main_navigation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'domain/entities/worship_event.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    
    // Initialize Isar with a proper directory for Android/iOS
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [WorshipEventSchema], 
      directory: dir.path, 
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
  } catch (e) {
    debugPrint("CRITICAL ERROR DURING INITIALIZATION: $e");
    // Fallback to a minimal app to show the error instead of a black screen
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text("خطأ فادح في التشغيل:\n$e", textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
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
