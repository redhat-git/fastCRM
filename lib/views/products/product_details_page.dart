import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Détails Produit")),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Icon(Icons.shopping_bag, size: 100, color: Colors.grey),
            const SizedBox(height: 20),
            const Text("Nom du Produit", style: TextStyle(fontSize: 24)),
            const SizedBox(height: 10),
            const Text("Description complète du produit ici..."),
            const Spacer(),
            ElevatedButton(onPressed: () {}, child: const Text("Modifier le produit")),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}