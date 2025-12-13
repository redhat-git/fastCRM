import 'package:flutter/material.dart';

class ClientDetailsPage extends StatelessWidget {
  const ClientDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Détails Client")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Nom: Client 1", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Email: client@exemple.com"),
            Text("Téléphone: +33 6 00 00 00 00"),
            Divider(),
            Text("Historique des commandes...", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}