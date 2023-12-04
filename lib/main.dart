import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/Providers/Provider_home.dart';
import 'package:mental_health/screens/Journal.dart';
import 'package:mental_health/screens/audioRecord.dart';
import 'package:mental_health/screens/chatAi.dart';
import 'package:mental_health/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NoteProvider()),
        ChangeNotifierProvider(create: (_) => FirstProvider()),
        ChangeNotifierProvider(create: (_) => ChatDataProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COMPANION',
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(scheme: FlexScheme.mandyRed),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.wasabi),
      themeMode: ThemeMode.system,
      home:   HomeScreen()
    );
  }
}
