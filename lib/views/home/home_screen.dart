import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Nécessite flutter pub add fl_chart

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7), // Fond blanc cassé/crème
      body: Stack(
        children: [
          // Contenu principal
          Column(
            children: [
              // Header personnalisé avec Logo
              Container(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
                decoration: const BoxDecoration(
                  color: Color(0xFFD6C0A6), // Beige foncé du haut
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/logo.png', height: 40), // Petit logo
                        const Icon(Icons.menu, size: 40, color: Color(0xFF0F2C59)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Onglets Tableau de bord / Historique
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const Text("Tableau de bord", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F2C59))),
                            Container(margin: const EdgeInsets.only(top: 5), height: 3, width: 100, color: const Color(0xFF0F2C59))
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            Text("Historique", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.7))),
                            Container(margin: const EdgeInsets.only(top: 5), height: 3, width: 80, color: Colors.transparent)
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Carte Graphique (Pie Chart)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(24),
                height: 300,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE2D0), // Beige de la carte
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Le graphique avec fl_chart
                    PieChart(
                      PieChartData(
                        sectionsSpace: 5,
                        centerSpaceRadius: 60,
                        sections: [
                          PieChartSectionData(color: Colors.blue[800], value: 52, title: "52%", radius: 25, titleStyle: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          PieChartSectionData(color: Colors.red, value: 42, title: "42%", radius: 25, titleStyle: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          PieChartSectionData(color: Colors.green, value: 10, title: "10%", radius: 25, titleStyle: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    // Texte au centre
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("32 clients", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Text("Total de clients", style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    )
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              // Petit point noir indicateur (pagination)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 10, height: 10, decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle)),
                ],
              )
            ],
          ),

          // Barre de navigation flottante en bas
          Positioned(
            bottom: 30,
            left: 30,
            right: 30,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFD6C0A6), // Beige nav bar
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _navItem(Icons.home_outlined, "Acceuil", true),
                  // Bouton Plus central
                  Container(
                    width: 60, height: 60,
                    decoration: const BoxDecoration(color: Color(0xFF0F2C59), shape: BoxShape.circle),
                    child: const Icon(Icons.add, color: Colors.white, size: 35),
                  ),
                  _navItem(Icons.folder_open_outlined, "Registre", false),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: const Color(0xFF0F2C59), size: 30),
        Text(label, style: const TextStyle(color: Color(0xFF0F2C59), fontWeight: FontWeight.bold, fontSize: 12)),
      ],
    );
  }
}