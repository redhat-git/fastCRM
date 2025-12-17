class ClientModel {
  final int? id;
  final String nom;
  final String entreprise;
  final String statut; // "Fidèle", "Neutre", "Occasionnel"
  final String contact; // Format: "Téléphone|Email"

  ClientModel({
    this.id,
    required this.nom,
    required this.entreprise,
    required this.statut,
    required this.contact,
  });
}