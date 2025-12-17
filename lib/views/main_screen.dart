import 'package:flutter/material.dart';
import 'clients/clients_list_page.dart';
import 'clients/widgets/client_form_page.dart'; // Nécessaire pour le bouton +
import 'history/history_page.dart';
import 'products/products_list_page.dart';
import 'analysis/analysis_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Liste des pages
  final List<Widget> _pages = [
    const AnalysisPage(),    // Index 0: Accueil / Dashboard
    const Center(child: Text("Action")), // Index 1: Bouton + (géré par onTap)
    const HistoryPage(),     // Index 2: Historique
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8D6BF), // Fond Beige Principal
      
      // --- HEADER (Barre de recherche) ---
      // Correspond à la partie haute de "Home alternatif.png"
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                // Logo
                const Icon(Icons.flash_on, size: 40, color: Color(0xFF1A3B6E)),
                const SizedBox(width: 10),
                
                // Barre de recherche
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Recherche",
                      fillColor: const Color(0xFFF0E6DA), // Beige très clair
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                      suffixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30), 
                        borderSide: BorderSide.none
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                
                // Bouton Filtre
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF0E6DA),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.filter_list, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),

      // --- CORPS DE LA PAGE ---
      body: _pages[_currentIndex],

      // --- BARRE DE NAVIGATION PERSONNALISÉE ---
      // Correspond au bas de "Home alternatif.png" et "historique.png"
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Color(0xFFD4C1A5), // Beige plus foncé
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // 1. Bouton Accueil
            IconButton(
              icon: Icon(
                Icons.home_outlined, 
                size: 32, 
                color: _currentIndex == 0 ? const Color(0xFF1A3B6E) : Colors.black54
              ),
              onPressed: () => setState(() => _currentIndex = 0),
            ),

            // 2. GROS BOUTON "+" CENTRAL (Flottant)
            GestureDetector(
              onTap: () {
                // Navigation vers le formulaire d'ajout
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ClientFormPage()));
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFF1A3B6E), // Bleu Nuit
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))
                  ]
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 35),
              ),
            ),

            // 3. Bouton Historique / Analyse
            IconButton(
              icon: Icon(
                Icons.history, // Ou Icons.analytics_outlined
                size: 32, 
                color: _currentIndex == 2 ? const Color(0xFF1A3B6E) : Colors.black54
              ),
              onPressed: () => setState(() => _currentIndex = 2),
            ),
          ],
        ),
      ),
    );
  }
}