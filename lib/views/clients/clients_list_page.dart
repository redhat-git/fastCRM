import 'package:flutter/material.dart';
import '../../models/client_model.dart';
import 'client_details_page.dart';

class ClientsListPage extends StatefulWidget {
  const ClientsListPage({super.key});

  @override
  State<ClientsListPage> createState() => _ClientsListPageState();
}

class _ClientsListPageState extends State<ClientsListPage> {
  // Données fictives pour l'interface
  final List<ClientModel> mockClients = [
    ClientModel(id: 1, nom: "Nabo Clément", entreprise: "Maturin_entreprise", statut: "Fidèle", contact: "+225 01032859|Bodoin@gmail.com"),
    ClientModel(id: 2, nom: "Colombe & Ulyce", entreprise: "Design Colab", statut: "Occasionnel", contact: "+225 07070707|colombe@design.com"),
    ClientModel(id: 3, nom: "Jean Dupont", entreprise: "Tech Solutions", statut: "Neutre", contact: "+33 612345678|jean@tech.com"),
    ClientModel(id: 4, nom: "Alice Martin", entreprise: "Marketing Pro", statut: "Fidèle", contact: "+33 700000000|alice@market.com"),
  ];

  @override
  Widget build(BuildContext context) {
    // Note: Pas de Scaffold ici car cette page est affichée DANS le MainScreen
    return Container(
      color: const Color(0xFFFDFBF7), // Fond crème global
      child: ListView.builder(
        // Padding top pour laisser la place au Header du MainScreen
        // Padding bottom pour le bouton "+" flottant
        padding: const EdgeInsets.only(top: 100, left: 16, right: 16, bottom: 100),
        itemCount: mockClients.length,
        itemBuilder: (context, index) {
          final client = mockClients[index];
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
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              title: Text(
                client.nom,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(client.entreprise, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  // Petit badge de statut
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getStatusColor(client.statut).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text(
                      client.statut, 
                      style: TextStyle(color: _getStatusColor(client.statut), fontSize: 10, fontWeight: FontWeight.bold)
                    ),
                  )
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ClientDetailsPage(client: client)));
              },
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String statut) {
    switch (statut) {
      case 'Fidèle': return Colors.blue;
      case 'Occasionnel': return Colors.orange;
      case 'Neutre': return Colors.grey;
      default: return Colors.black;
    }
  }
}