import 'package:flutter/material.dart';
import '../../../models/history_model.dart';

class HistoryItem extends StatelessWidget {
  final HistoryModel history;

  const HistoryItem({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F4EF), // Beige clair des cartes
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ligne supérieure : Titre + Lien "Voir plus"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                history.titre,
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
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),

          // Date
          Text(
            history.date,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 8),

          // Description (ex: Nom du client)
          // On vérifie si c'est une modif de statut pour afficher la flèche
          if (history.description.contains('-->'))
            _buildStatusChange(history.description)
          else
            Text(
              history.description,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
        ],
      ),
    );
  }

  // Petit widget helper pour formater "Neutre --> Fidèle" avec des couleurs
  Widget _buildStatusChange(String text) {
    final parts = text.split('-->');
    if (parts.length < 2) return Text(text);

    return Row(
      children: [
        const Icon(Icons.circle, size: 8, color: Colors.grey),
        const SizedBox(width: 4),
        Text(parts[0].trim(), style: const TextStyle(color: Colors.grey)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
        ),
        const Icon(Icons.circle, size: 8, color: Colors.blue),
        const SizedBox(width: 4),
        Text(parts[1].trim(), style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
      ],
    );
  }
}