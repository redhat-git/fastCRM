import 'package:flutter/material.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tableau de bord")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Placeholder pour un graphique
            Container(
              height: 200,
              color: Colors.blue[50],
              child: const Center(child: Text("Graphique des Ventes (À implémenter)")),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _statCard("Clients", "120")),
                const SizedBox(width: 10),
                Expanded(child: _statCard("Revenu", "50k€")),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _statCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text(title, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}