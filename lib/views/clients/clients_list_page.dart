import 'package:flutter/material.dart';
import '../../database/database_helper.dart';
import '../../models/client_model.dart';
import '../../controllers/gestionnaire.dart';
import 'client_details_page.dart';

class ClientsListPage extends StatefulWidget {
  const ClientsListPage({super.key});

  @override
  State<ClientsListPage> createState() => _ClientsListPageState();
}

class _ClientsListPageState extends State<ClientsListPage> {
  Future<List<Client>> _fetchClients() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await Client.getAll(db);
    return List.generate(maps.length, (i) => Client.fromMap(maps[i]));
  }

  void refresh() {
    setState(() {});
  }

  void _deleteClient(int id) async {
    await Gestionnaire.supprimerClient(id);
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE8D6BF), // Fond Beige global
      child: FutureBuilder<List<Client>>(
        future: _fetchClients(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Gestion cas vide (Image "Home alternatif")
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.file_copy_outlined,
                      size: 100, color: Colors.black26),
                  SizedBox(height: 20),
                  Text("Vous n'avez pas encore de\nclient(e) enregistré(e).",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black45, fontSize: 16)),
                  Text("Appuyer sur le [+] pour en créer.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black45, fontSize: 16)),
                ],
              ),
            );
          }

          final clients = snapshot.data!;
          return ListView.builder(
            // Padding pour éviter que ça touche les bords ou la barre de recherche
            padding: const EdgeInsets.only(
                top: 20, left: 16, right: 16, bottom: 100),
            itemCount: clients.length,
            itemBuilder: (context, index) {
              final client = clients[index];
              final statusColor = _getStatusColor(client.statut);

              return Container(
                height: 72, // Hauteur fixe pour coller à la maquette
                margin: const EdgeInsets.only(
                    bottom: 15), // Espacement entre les cartes
                decoration: BoxDecoration(
                  color: const Color(
                      0xFFEFE6DD), // Beige clair de la carte (cf image)
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2))
                  ],
                ),
                child: Row(
                  children: [
                    // 1. BARRE DE COULEUR (Gauche)
                    Container(
                      width: 12,
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                    ),

                    // 2. NOM DU CLIENT (Centre)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          client.nom,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black87),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),

                    // 3. ZONE D'ACTIONS (Droite - Fond plus foncé)
                    Container(
                      width: 90,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE0CDB2), // Beige plus foncé
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Oeil (Détails)
                          InkWell(
                            onTap: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          ClientDetailsPage(client: client)));
                              refresh();
                            },
                            child: const Icon(Icons.remove_red_eye_outlined,
                                color: Color(0xFF1A3B6E), size: 24),
                          ),
                          // Poubelle (Supprimer)
                          InkWell(
                            onTap: () => _deleteClient(client.id!),
                            child: const Icon(Icons.delete_outline,
                                color: Color(0xFF1A3B6E), size: 24),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Color _getStatusColor(String statut) {
    // Couleurs vives comme sur la maquette "Home.png"
    if (statut == 'Fidèle') return const Color(0xFF2A36FF); // Bleu électrique
    if (statut == 'Occasionnel') return const Color(0xFFFF0000); // Rouge vif
    if (statut == 'Neutre') return Colors.grey;
    return Colors.grey;
  }
}
