import 'package:flutter/material.dart';
import 'views/intro/welcome_page.dart';
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
        scaffoldBackgroundColor: const Color(0xFFE6D6C4), // Le beige de fond principal
        primaryColor: const Color(0xFF0F2C59), // Le bleu nuit du logo
        
        // Définition de la palette de couleurs
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F2C59),
          primary: const Color(0xFF0F2C59),
          secondary: const Color(0xFFE6D6C4),
          surface: const Color(0xFFF2EFE9),
        ),

        // Style des champs de texte (arrondis blancs comme sur Inscription)
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30), // Très arrondi
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}