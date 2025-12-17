import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../database/database_helper.dart';
import '../../models/client_model.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  int totalClients = 0;
  int fideles = 0;
  int neutres = 0;
  int occasionnels = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _calculateStats();
  }

  Future<void> _calculateStats() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await Client.getAll(db);

    int f = 0, n = 0, o = 0;
    for (var client in maps) {
      String s = client['statut'] ?? '';
      if (s == 'Fidèle')
        f++;
      else if (s == 'Neutre')
        n++;
      else
        o++;
    }

    if (mounted) {
      setState(() {
        totalClients = maps.length;
        fideles = f;
        neutres = n;
        occasionnels = o;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Fond global beige
    return Container(
      color: const Color(0xFFE8D6BF),
      child: Column(
        children: [
          const SizedBox(height: 50), // Espace pour la barre de statut

          // Header "FastCRM" + Menu (Style WhatsApp Image)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Logo miniature
                    Image.asset('assets/logo.png',
                        height: 30,
                        errorBuilder: (c, e, s) => const Icon(Icons.flash_on,
                            color: Color(0xFF1A3B6E))),
                    const SizedBox(width: 10),
                    const Text("FastCRM",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A3B6E),
                            fontSize: 20)),
                  ],
                ),
                const Icon(Icons.menu, size: 30, color: Color(0xFF1A3B6E)),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Onglets (Tableau de bord / Historique)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const Text("Tableau de bord",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A3B6E),
                          fontSize: 16)),
                  const SizedBox(height: 5),
                  Container(
                      height: 3,
                      width: 80,
                      color: const Color(0xFF1A3B6E)) // Soulignement
                ],
              ),
              const SizedBox(width: 30),
              // Historique en gris/blanc (inactif)
              Text("Historique",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16)),
            ],
          ),

          const SizedBox(height: 40),

          // Carte Graphique
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(24),
                    height: 320,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3E9DD), // Beige clair carte
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Stack(
                            alignment: Alignment.center,
                            children: [
                              PieChart(PieChartData(
                                  sectionsSpace:
                                      0, // Pas d'espace entre sections
                                  centerSpaceRadius: 70,
                                  startDegreeOffset: -90,
                                  sections: [
                                    if (fideles > 0)
                                      _buildSection(
                                          fideles, const Color(0xFF1A3B6E)),
                                    if (neutres > 0)
                                      _buildSection(neutres, Colors.grey),
                                    if (occasionnels > 0)
                                      _buildSection(
                                          occasionnels,
                                          const Color(
                                              0xFFD4C1A5)), // Beige foncé/Rouge selon préférence
                                  ])),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("$totalClients",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 32,
                                          color: Color(0xFF1A3B6E))),
                                  const Text("Clients Total",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey)),
                                ],
                              )
                            ],
                          ),
                  ),
                  const SizedBox(height: 20),

                  // Légende
                  if (totalClients > 0)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _legendItem("Fidèle", const Color(0xFF1A3B6E)),
                        _legendItem("Neutre", Colors.grey),
                        _legendItem("Occasionnel", const Color(0xFFD4C1A5)),
                      ],
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  PieChartSectionData _buildSection(int value, Color color) {
    return PieChartSectionData(
      color: color,
      value: value.toDouble(),
      title: "${(value / totalClients * 100).round()}%",
      radius: 30,
      titleStyle: const TextStyle(
          color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
    );
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      children: [
        Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label,
            style: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
