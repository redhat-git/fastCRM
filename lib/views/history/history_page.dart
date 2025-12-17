import 'package:flutter/material.dart';
import '../../models/history_model.dart';
import 'widgets/history_item.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // Données fictives basées sur votre image "historique.png"
  final List<HistoryModel> mockHistory = [
    HistoryModel(
      id: 1,
      type: "Ajout",
      titre: "Ajout de client",
      description: "Nom: Norbert",
      date: "10/11/2025   12:30",
    ),
    HistoryModel(
      id: 2,
      type: "Modification",
      titre: "Mise à jour de statut",
      description: "Neutre --> Fidèle",
      date: "10/11/2025   12:30",
    ),
    HistoryModel(
      id: 3,
      type: "Modification",
      titre: "Mise à jour de Client",
      description: "Modification des informations du client",
      date: "10/11/2025   12:30",
    ),
    HistoryModel(
      id: 4,
      type: "Suppression",
      titre: "Suppression de client",
      description: "Nom: Norbert",
      date: "10/11/2025   12:30",
    ),
    HistoryModel(
      id: 5,
      type: "Ajout",
      titre: "Ajout de client",
      description: "Nom: Norbert",
      date: "10/11/2025   12:30",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Si la liste est vide (pour tester l'écran vide "historique alternatif")
    if (mockHistory.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history_toggle_off, size: 100, color: Colors.black12),
            SizedBox(height: 20),
            Text(
              "Aucun historique pour le moment",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      );
    }

    // Liste normale
    return Container(
      color: const Color(0xFFFDFBF7), // Fond crème global
      child: ListView.builder(
        // Padding top pour laisser la place au Header du MainScreen (Barre recherche)
        // Padding bottom pour la Nav Bar
        padding: const EdgeInsets.only(top: 100, left: 16, right: 16, bottom: 100),
        itemCount: mockHistory.length,
        itemBuilder: (context, index) {
          return HistoryItem(history: mockHistory[index]);
        },
      ),
    );
  }
}