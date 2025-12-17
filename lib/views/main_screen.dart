import 'package:flutter/material.dart';
import 'clients/clients_list_page.dart';
import 'clients/widgets/client_form_page.dart';
import 'history/history_page.dart';
// import 'analysis/analysis_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const ClientsListPage(), // Accueil (Liste)
    const Center(child: Text("Action")), // Placeholder bouton +
    const HistoryPage(), // Historique
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8D6BF), // Fond Beige Global

      // --- HEADER PERSONNALISÉ (2 LIGNES) ---
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(130), // Hauteur augmentée pour 2 lignes
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: const Color(0xFFE8D6BF), // Fond beige header
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // LIGNE 1 : Logo + Menu
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo
                    Row(
                      children: [
                        Image.asset('assets/logo.png',
                            height: 35,
                            errorBuilder: (c, e, s) => const Icon(
                                Icons.flash_on,
                                color: Color(0xFF1A3B6E),
                                size: 35)),
                        // Si vous avez le texte dans l'image logo, retirez ce Text widget
                        // const SizedBox(width: 5),
                        // const Text("Fast CRM", style: TextStyle(fontFamily: 'Arial', fontWeight: FontWeight.bold, color: Color(0xFF1A3B6E), fontSize: 20)),
                      ],
                    ),
                    // Menu Hamburger (Bleu foncé, traits épais)
                    const Icon(Icons.menu, size: 35, color: Color(0xFF1A3B6E)),
                  ],
                ),

                const SizedBox(height: 15),

                // LIGNE 2 : Recherche + Tri + Filtre
                Row(
                  children: [
                    // Barre de Recherche
                    Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color:
                              const Color(0xFFEFE6DD), // Beige très clair/Grisé
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: "Recherche",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            suffixIcon:
                                Icon(Icons.search, color: Colors.black54),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Bouton Tri (Flèche bas)
                    _buildHeaderButton(Icons.sort), // Ou Icons.swap_vert

                    const SizedBox(width: 10),

                    // Bouton Filtre (Entonnoir)
                    _buildHeaderButton(Icons.filter_alt_outlined),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      body: _pages[_currentIndex],

      // --- NAVIGATION BAR COURBE ---
      bottomNavigationBar: Container(
        height: 85, // Hauteur ajustée
        decoration: const BoxDecoration(
          color: Color(0xFFD4C1A5), // Beige foncé navigation
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Onglet Accueil
            _buildNavItem(
                icon: Icons.home_outlined,
                label: "Accueil",
                isSelected: _currentIndex == 0,
                onTap: () => setState(() => _currentIndex = 0)),

            // GROS BOUTON "+"
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ClientFormPage())),
              child: Container(
                width: 65, height: 65,
                margin: const EdgeInsets.only(bottom: 10), // Remonte légèrement
                decoration: const BoxDecoration(
                    color: Color(0xFF1A3B6E), // Bleu Nuit
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4))
                    ]),
                child: const Icon(Icons.add, color: Colors.white, size: 40),
              ),
            ),

            // Onglet Historique
            _buildNavItem(
                icon: Icons
                    .history, // Ou Icons.assignment_outlined pour ressembler à l'icone dossier/horloge
                label: "Historique",
                isSelected: _currentIndex == 2,
                onTap: () => setState(() => _currentIndex = 2)),
          ],
        ),
      ),
    );
  }

  // Widget pour les petits boutons ronds du header (Filtre/Tri)
  Widget _buildHeaderButton(IconData icon) {
    return Container(
      width: 45,
      height: 45,
      decoration: const BoxDecoration(
        color: Color(0xFFEFE6DD), // Même couleur que la barre de recherche
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.black87, size: 24),
    );
  }

  // Widget pour les items de navigation (Icône + Texte)
  Widget _buildNavItem(
      {required IconData icon,
      required String label,
      required bool isSelected,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            // Petit fond si sélectionné (optionnel, pour faire ressortir)
            // decoration: isSelected ? BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)) : null,
            child: Icon(icon,
                size: 30,
                color: isSelected
                    ? const Color(0xFF1A3B6E)
                    : const Color(0xFF1A3B6E).withOpacity(0.5)),
          ),
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? const Color(0xFF1A3B6E)
                      : const Color(0xFF1A3B6E).withOpacity(0.5)))
        ],
      ),
    );
  }
}
