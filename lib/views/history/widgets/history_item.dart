import 'package:flutter/material.dart';

class HistoryItem extends StatelessWidget {
  final String titre;
  final String description;
  final String date;

  const HistoryItem({
    super.key,
    required this.titre,
    required this.description,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F4EF), // Beige très clair (cf image)
        borderRadius: BorderRadius.circular(8), // Coins légèrement arrondis
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LIGNE 1 : Titre + "Voir plus"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titre, // Ex: "Ajout de client"
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const Text(
                "Voir plus",
                style: TextStyle(
                  color: Color(0xFF1A3B6E), // Bleu FastCRM
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          // LIGNE 2 : Date (Gris)
          Text(
            date, // Ex: "10/11/2025 12:30"
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),

          const SizedBox(height: 8),

          // LIGNE 3 : Description / Nom / Statut
          // Gestion du cas "Neutre --> Fidèle" avec flèche
          if (description.contains('-->'))
            _buildStatusChange(description)
          else
            Text(
              description, // Ex: "Nom: Norbert"
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
        ],
      ),
    );
  }

  // Widget pour formater "Neutre --> Fidèle"
  Widget _buildStatusChange(String text) {
    final parts = text.split('-->');
    if (parts.length < 2) return Text(text);

    return Row(
      children: [
        // Point gris + Ancien statut
        const Icon(Icons.circle, size: 8, color: Colors.grey),
        const SizedBox(width: 5),
        Text(parts[0].trim(),
            style: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold)),

        // Flèche longue
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(Icons.east, size: 20, color: Colors.grey),
        ),

        // Point bleu + Nouveau statut
        const Icon(Icons.circle, size: 8, color: Color(0xFF2A36FF)), // Bleu vif
        const SizedBox(width: 5),
        Text(parts[1].trim(),
            style: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
