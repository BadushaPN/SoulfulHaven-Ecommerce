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
        primaryColor: const Color(0xFF006D77),
        scaffoldBackgroundColor: const Color(0xFFEDF6F9),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF006D77),
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF83C5BE),
        ),
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
