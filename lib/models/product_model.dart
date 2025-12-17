class ProductModel {
  final int? id;
  final String nom;
  final String categorie;
  final double prix;
  final int stock;
  final String description;

  ProductModel({
    this.id,
    required this.nom,
    required this.categorie,
    required this.prix,
    required this.stock,
    this.description = "",
  });
}