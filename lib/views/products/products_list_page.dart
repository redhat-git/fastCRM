import 'package:flutter/material.dart';
import 'product_details_page.dart';

class ProductsListPage extends StatelessWidget {
  const ProductsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Catalogue Produits")),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductDetailsPage())),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_bag, size: 40, color: Colors.blue),
                  const SizedBox(height: 10),
                  Text("Produit ${index + 1}"),
                  const Text("150.00 €", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}