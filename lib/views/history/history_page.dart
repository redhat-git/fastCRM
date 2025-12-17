import 'package:flutter/material.dart';
import '../../database/database_helper.dart';
import '../../models/history_model.dart';
import 'widgets/history_item.dart';

class DisplayHistoryItem {
  final String lib;
  final String type;
  final String date;
  DisplayHistoryItem(
      {required this.lib, required this.type, required this.date});
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Future<List<DisplayHistoryItem>> _fetchHistory() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> rawData = await HistoriqueModel.getAll(db);
    return rawData
        .map((map) => DisplayHistoryItem(
              lib: map['lib'] ?? '',
              type: map['type'] ?? '',
              date: map['date'] ?? '',
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    // Fond global beige identique à la liste des clients
    return Container(
      color: const Color(0xFFE8D6BF),
      child: FutureBuilder<List<DisplayHistoryItem>>(
        future: _fetchHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // État vide (historique alternatif.png)
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.file_copy_outlined,
                      size: 80, color: Colors.black26),
                  SizedBox(height: 20),
                  Text("Vous n'avez pas encore\nd'historique enregistré.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black45, fontSize: 16)),
                ],
              ),
            );
          }

          final historyList = snapshot.data!;
          return ListView.builder(
            // Padding pour passer sous le header MainScreen (Recherche)
            padding: const EdgeInsets.only(
                top: 20, left: 16, right: 16, bottom: 100),
            itemCount: historyList.length,
            itemBuilder: (context, index) {
              final item = historyList[index];
              return HistoryItem(
                titre: _formatTitle(item.type),
                description: item.lib,
                date: item.date,
              );
            },
          );
        },
      ),
    );
  }

  String _formatTitle(String type) {
    if (type == 'AJOUT') return "Ajout de client";
    if (type == 'MODIFICATION')
      return "Mise à jour de client"; // ou "Mise à jour de statut" selon contenu
    if (type == 'SUPPRESSION') return "Suppression de client";
    return type;
  }
}
