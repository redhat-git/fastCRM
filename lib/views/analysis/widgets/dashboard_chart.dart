import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Assure-toi d'avoir ajouté fl_chart dans pubspec.yaml

class DashboardChart extends StatelessWidget {
  const DashboardChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      height: 320,
      decoration: BoxDecoration(
        color: const Color(0xFFEDE2D0), // Beige de la carte
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // LE GRAPHIQUE
          PieChart(
            PieChartData(
              sectionsSpace: 4,
              centerSpaceRadius: 60,
              startDegreeOffset: -90,
              sections: [
                PieChartSectionData(
                  color: const Color(0xFF0F2C59), // Bleu Nuit (Marque)
                  value: 52,
                  title: "52%",
                  radius: 25,
                  titleStyle: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
                PieChartSectionData(
                  color: const Color(0xFFC96868), // Rouge/Rose atténué
                  value: 38,
                  title: "38%",
                  radius: 22,
                  titleStyle: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                ),
                PieChartSectionData(
                  color: const Color(0xFF7EAA92), // Vert sauge
                  value: 10,
                  title: "10%",
                  radius: 18,
                  titleStyle: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // TEXTE CENTRAL
          const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "32",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, color: Color(0xFF0F2C59)),
              ),
              Text(
                "Clients Total",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }
}