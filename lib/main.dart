import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme/app_theme.dart';
import 'ui/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: EasyTimetableApp(),
    ),
  );
}

class EasyTimetableApp extends StatelessWidget {
  const EasyTimetableApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Easy Timetable',
      theme: AppTheme.themeData,
      home: const HomeScreen(),
      localizationsDelegates: const [
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
    );
  }
}
