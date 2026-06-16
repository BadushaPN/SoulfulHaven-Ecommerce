import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routing/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Soulful Haven',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF00B4D8), // Electric Cyan
        scaffoldBackgroundColor: const Color(0xFFFAF9F6),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF00B4D8),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00B4D8),
          primary: const Color(0xFF00B4D8),
          secondary: const Color(0xFF00F5D4), // Neon Turquoise
          tertiary: const Color(0xFFFF007F),  // Neon Pink
          background: const Color(0xFFFAF9F6),
        ),
        cardTheme: const CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
