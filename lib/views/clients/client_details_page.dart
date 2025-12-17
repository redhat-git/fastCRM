import 'package:flutter/material.dart';
import '../../models/client_model.dart';
import 'widgets/client_form_page.dart';

class ClientDetailsPage extends StatelessWidget {
  final ClientModel client;
  const ClientDetailsPage({super.key, required this.client});

  // --- POPUP DE SUPPRESSION ---
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFFE0CDB2), // Fond beige foncé
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: const [
            Icon(Icons.close, size: 28),
            SizedBox(width: 10),
            Expanded(child: Text("Suppression en cours", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
          ],
        ),
        content: const Text(
          "La suppression d’un client est définitive voulez vous quand meme continuer",
          style: TextStyle(fontSize: 16),
        ),
        actionsPadding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          // Bouton OUI
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE0CDB2),
              elevation: 0,
              side: const BorderSide(color: Colors.green, width: 2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              // TODO: Suppression réelle
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text("oui", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          // Bouton NON
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE0CDB2),
              elevation: 0,
              side: const BorderSide(color: Colors.red, width: 2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Non", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Parsing Contact
    String phone = "";
    String email = "";
    if (client.contact.contains('|')) {
      var parts = client.contact.split('|');
      phone = parts[0];
      if (parts.length > 1) email = parts[1];
    } else {
      phone = client.contact;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFE8D6BF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8D6BF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Page client", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.black),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ClientFormPage(client: client))),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.black),
            onPressed: () => _showDeleteDialog(context),
          ),
        ],
      ),
      body: Center(
        child: Container(
          // --- LA CARTE À BORDURE BLEUE ---
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.82,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFF3E9DD), // Fond intérieur
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: const Color(0xFF3500D3), width: 3), // BLEU ÉLECTRIQUE
          ),
          child: Column(
            children: [
              _buildInfoPill("Nom:", client.nom),
              const SizedBox(height: 12),
              _buildInfoPill("type de client :", "Professionnel"), // Statique pour l'instant
              const SizedBox(height: 12),
              _buildInfoPill("Entreprise:", client.entreprise),
              const SizedBox(height: 12),
              
              // Bloc Contact
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(color: const Color(0xFFE8D6BF), borderRadius: BorderRadius.circular(25)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Contact:", style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 5),
                    Text(phone, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const Text("Mobile", style: TextStyle(fontSize: 10, color: Colors.grey)),
                    const SizedBox(height: 10),
                    Text(email, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const Text("E-mail", style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Statut
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(color: const Color(0xFFE8D6BF), borderRadius: BorderRadius.circular(25)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Statut du client :", style: TextStyle(color: Colors.grey)),
                        Text(client.statut, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      ],
                    ),
                    Container(
                      width: 40, height: 30, 
                      decoration: BoxDecoration(
                        color: const Color(0xFF3500D3), // Carré bleu
                        borderRadius: BorderRadius.circular(5)
                      )
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoPill(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFE8D6BF),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          Text(value, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}