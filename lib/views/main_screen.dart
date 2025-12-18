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

  // --- VARIABLES D'ÉTAT (Recherche, Tri, Filtre) ---
  String _searchQuery = "";
  bool _sortAscending = true;
  String _filterStatus = "Tous"; // <--- CETTE VARIABLE DOIT ÊTRE DÉFINIE ICI

  // Construction dynamique de la page
  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        // On passe le filtre à la liste des clients
        return ClientsListPage(
          searchQuery: _searchQuery,
          sortAscending: _sortAscending,
          filterStatus:
              _filterStatus, // <--- Utilise la variable définie plus haut
        );
      case 2:
        return const HistoryPage();
      default:
        return const SizedBox();
    }
  }

  // Menu pour choisir le filtre
  void _showFilterMenu(BuildContext context) async {
    final String? selected = await showMenu<String>(
      context: context,
      position: const RelativeRect.fromLTRB(100, 140, 20, 0),
      color: const Color(0xFFF3E9DD),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      items: [
        const PopupMenuItem(value: "Tous", child: Text("Tous les statuts")),
        const PopupMenuItem(value: "Fidèle", child: Text("Fidèle")),
        const PopupMenuItem(value: "Neutre", child: Text("Neutre")),
        const PopupMenuItem(value: "Occasionnel", child: Text("Occasionnel")),
      ],
    );

    if (selected != null) {
      setState(() {
        _filterStatus = selected; // Mise à jour de la variable
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8D6BF),

      // AppBar visible seulement sur l'accueil (index 0)
      appBar: _currentIndex == 0
          ? PreferredSize(
              preferredSize: const Size.fromHeight(130),
              child: SafeArea(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: const Color(0xFFE8D6BF),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // LIGNE 1 : Logo (Burger supprimé)
                      Row(
                        children: [
                          Image.asset('assets/logo.png',
                              height: 35,
                              errorBuilder: (c, e, s) => const Icon(
                                  Icons.flash_on,
                                  color: Color(0xFF1A3B6E),
                                  size: 35)),
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
                                color: const Color(0xFFEFE6DD),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextField(
                                onChanged: (value) {
                                  setState(() => _searchQuery = value);
                                },
                                decoration: const InputDecoration(
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

                          // Bouton Tri
                          GestureDetector(
                            onTap: () {
                              setState(() => _sortAscending = !_sortAscending);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    _sortAscending ? "Tri : A-Z" : "Tri : Z-A"),
                                duration: const Duration(milliseconds: 500),
                                backgroundColor: const Color(0xFF1A3B6E),
                              ));
                            },
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: const BoxDecoration(
                                color: Color(0xFFEFE6DD),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                  _sortAscending
                                      ? Icons.arrow_downward
                                      : Icons.arrow_upward,
                                  color: Colors.black87,
                                  size: 24),
                            ),
                          ),

                          const SizedBox(width: 10),

                          // Bouton Filtre (Fonctionnel)
                          GestureDetector(
                            onTap: () => _showFilterMenu(context),
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                // Change de couleur si un filtre est actif
                                color: _filterStatus == "Tous"
                                    ? const Color(0xFFEFE6DD)
                                    : const Color(0xFF1A3B6E),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.filter_alt_outlined,
                                  // Change d'icone/couleur si actif
                                  color: _filterStatus == "Tous"
                                      ? Colors.black87
                                      : Colors.white,
                                  size: 24),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,

      body: _buildBody(),

      bottomNavigationBar: Container(
        height: 85,
        decoration: const BoxDecoration(
          color: Color(0xFFD4C1A5),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
                icon: Icons.home_outlined, label: "Accueil", index: 0),

            // Bouton Ajout (Actualise au retour)
            GestureDetector(
              onTap: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ClientFormPage()));
                setState(() {}); // Rafraîchissement
              },
              child: Container(
                width: 65,
                height: 65,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: const BoxDecoration(
                    color: Color(0xFF1A3B6E),
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

            _buildNavItem(icon: Icons.history, label: "Historique", index: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      {required IconData icon, required String label, required int index}) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              size: 30,
              color: isSelected
                  ? const Color(0xFF1A3B6E)
                  : const Color(0xFF1A3B6E).withOpacity(0.5)),
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
