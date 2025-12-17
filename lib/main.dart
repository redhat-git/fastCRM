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

      // --- THÈME GLOBAL ---
      theme: ThemeData(
        useMaterial3: true,
        fontFamily:
            'Arial', // Tu peux changer pour 'Poppins' ou 'Roboto' si tu as importé une font

        // 1. Couleurs extraites de tes images (Pipette)
        scaffoldBackgroundColor:
            const Color(0xFFE8D6BF), // Le Beige exact du fond
        primaryColor:
            const Color(0xFF1A3B6E), // Le Bleu nuit exact du logo/boutons

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A3B6E), // Bleu nuit
          primary: const Color(0xFF1A3B6E),
          secondary: const Color(0xFFD4C1A5), // Beige plus foncé (Barre de nav)
          surface: const Color(0xFFF3E9DD), // Fond des cartes/cards
          onPrimary: Colors.white, // Texte sur les boutons bleus
        ),

        // 2. Style des champs de texte (Input)
        // Par défaut : Arrondis (comme la barre de recherche et Login)
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(
              0xFFF0E6DA), // Beige très clair (intérieur des champs)
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

          // Bordure par défaut (arrondie sans trait)
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),

          // Bordure quand on clique (Focus)
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Color(0xFF1A3B6E), width: 1.5),
          ),

          hintStyle: TextStyle(color: Colors.grey[600]),
          labelStyle: const TextStyle(color: Colors.black54),
        ),

        // 3. Style des Boutons (ElevatedButton)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A3B6E), // Bleu nuit
            foregroundColor: Colors.white, // Texte blanc
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Boutons très arrondis
            ),
          ),
        ),

        // 4. Style des Icones (AppBar, etc.)
        iconTheme: const IconThemeData(
          color: Color(0xFF1A3B6E),
        ),
      ),

      // --- POINT D'ENTRÉE ---
      // On commeence par le chargemenet pour tester le design
      home: const SplashScreen(),
    );
  }
}
