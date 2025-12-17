import 'package:flutter/material.dart';
// Pas de modèle produit importé car pas de backend pour l'instant
import 'widgets/product_form_page.dart';

class ProductsListPage extends StatelessWidget {
  const ProductsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7),
      appBar: AppBar(
        title: const Text("Mes Produits",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFE8D6BF),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      // LISTE VIDE (Pas de mock data)
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey),
            SizedBox(height: 20),
            Text(
              "Aucun produit enregistré.",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "(Module produit non connecté à la BDD)",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1A3B6E),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          // Le formulaire s'ouvrira mais ne pourra pas sauvegarder en BDD sans modification du backend
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const ProductFormPage()));
        },
      ),
    );
  }
}
