import 'package:flutter/material.dart';
import 'views/intro/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fast CRM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFFE8D6BF),
        primaryColor: const Color(0xFF1A3B6E),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A3B6E),
          primary: const Color(0xFF1A3B6E),
          secondary: const Color(0xFFD4C1A5),
          surface: const Color(0xFFF3E9DD),
          onPrimary: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF0E6DA),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  const BorderSide(color: Color(0xFF1A3B6E), width: 1.5)),
          hintStyle: TextStyle(color: Colors.grey[600]),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A3B6E),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF1A3B6E)),
      ),
      home: const SplashScreen(),
    );
  }
}
