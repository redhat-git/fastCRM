import 'package:flutter/material.dart';
import 'client_details_page.dart';

class ClientsListPage extends StatelessWidget {
  const ClientsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes Clients", style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor, // Bleu fond
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.white,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                child: Text(
                  "C${index + 1}",
                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                "Client Entreprise ${index + 1}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  const Text("contact@entreprise.com"),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: const Text("Actif", style: TextStyle(color: Colors.green, fontSize: 12)),
                  )
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ClientDetailsPage()));
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}