import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import 'widgets/product_form_page.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductModel product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8D6BF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8D6BF),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text("Détail Produit", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.black),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductFormPage(product: product))),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.black),
            onPressed: () {
              // Popup suppression identique aux clients
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.6, // Carte moins haute que client
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: const Color(0xFFF3E9DD),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: const Color(0xFF3500D3), width: 3), // Bordure bleue
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 80, height: 80,
                  decoration: BoxDecoration(color: const Color(0xFF1A3B6E).withOpacity(0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.shopping_bag_outlined, size: 40, color: Color(0xFF1A3B6E)),
                ),
              ),
              const SizedBox(height: 20),
              
              const Text("Nom du produit", style: TextStyle(color: Colors.grey, fontSize: 12)),
              Text(product.nom, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)),
              const SizedBox(height: 15),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Catégorie", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text(product.categorie, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("Prix Unitaire", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text("${product.prix.toStringAsFixed(0)} FCFA", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1A3B6E))),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              const Text("Description", style: TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 5),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(color: const Color(0xFFE8D6BF).withOpacity(0.5), borderRadius: BorderRadius.circular(15)),
                  child: Text(product.description, style: const TextStyle(fontSize: 14)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}