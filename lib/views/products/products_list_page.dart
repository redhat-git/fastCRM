import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import 'product_details_page.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({super.key});

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  // Données fictives
  final List<ProductModel> mockProducts = [
    ProductModel(id: 1, nom: "Licence CRM Basic", categorie: "Logiciel", prix: 15000, stock: 999, description: "Licence mensuelle pour un utilisateur."),
    ProductModel(id: 2, nom: "Formation Équipe", categorie: "Service", prix: 50000, stock: 5, description: "Formation sur site pour 5 personnes."),
    ProductModel(id: 3, nom: "Maintenance An.", categorie: "Support", prix: 120000, stock: 20, description: "Contrat de maintenance annuel."),
    ProductModel(id: 4, nom: "Serveur Dédié", categorie: "Matériel", prix: 450000, stock: 2, description: "Serveur physique haute performance."),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7), // Fond crème
      // On met un Header simple si cette page est autonome, 
      // ou on l'intègre au MainScreen comme ClientsListPage
      appBar: AppBar(
        title: const Text("Mes Produits", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFE8D6BF),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false, // Pas de flèche retour si c'est un onglet principal
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockProducts.length,
        itemBuilder: (context, index) {
          final product = mockProducts[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F4EF), // Beige carte
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                width: 50, height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A3B6E).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.inventory_2_outlined, color: Color(0xFF1A3B6E)),
              ),
              title: Text(
                product.nom,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text("${product.prix.toStringAsFixed(0)} FCFA  •  Stock: ${product.stock}"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailsPage(product: product)));
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1A3B6E),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          // Vers ProductFormPage (à créer ci-dessous)
          Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductFormPage()));
        },
      ),
    );
  }
}