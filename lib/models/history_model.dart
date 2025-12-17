class HistoryModel {
  final int? id;
  final String type; // "Ajout", "Modification", "Suppression"
  final String titre; // Ex: "Ajout de client"
  final String description; // Ex: "Nom: Norbert" ou "Neutre -> Fidèle"
  final String date; // Ex: "10/11/2025 12:30"

  HistoryModel({
    this.id,
    required this.type,
    required this.titre,
    required this.description,
    required this.date,
  });
}