import 'package:flutter/material.dart';
import '../../database/database_helper.dart';
import '../../models/client_model.dart';
import '../../controllers/gestionnaire.dart';
import 'client_details_page.dart';

class ClientsListPage extends StatefulWidget {
  final String searchQuery;
  final bool sortAscending;
  final String
      filterStatus; // <--- Ce champ est OBLIGATOIRE pour que MainScreen fonctionne

  const ClientsListPage({
    super.key,
    required this.searchQuery,
    required this.sortAscending,
    required this.filterStatus, // <--- Constructeur mis à jour
  });

  @override
  State<ClientsListPage> createState() => _ClientsListPageState();
}

class _ClientsListPageState extends State<ClientsListPage> {
  Future<List<Client>> _fetchAndFilterClients() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await Client.getAll(db);

    List<Client> allClients =
        List.generate(maps.length, (i) => Client.fromMap(maps[i]));

    // 1. FILTRE PAR STATUT
    if (widget.filterStatus != "Tous") {
      allClients = allClients
          .where((client) => client.statut == widget.filterStatus)
          .toList();
    }

    // 2. RECHERCHE
    if (widget.searchQuery.isNotEmpty) {
      final query = widget.searchQuery.toLowerCase();
      allClients = allClients.where((client) {
        return client.nom.toLowerCase().contains(query) ||
            client.entreprise.toLowerCase().contains(query);
      }).toList();
    }

    // 3. TRI
    allClients.sort((a, b) {
      int cmp = a.nom.toLowerCase().compareTo(b.nom.toLowerCase());
      return widget.sortAscending ? cmp : -cmp;
    });

    return allClients;
  }

  void refresh() => setState(() {});

  void _deleteClient(int id) async {
    await Gestionnaire.supprimerClient(id);
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE8D6BF),
      child: FutureBuilder<List<Client>>(
        future: _fetchAndFilterClients(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            String msg = "Aucun client enregistré.";
            if (widget.filterStatus != "Tous")
              msg = "Aucun client \"${widget.filterStatus}\".";
            else if (widget.searchQuery.isNotEmpty)
              msg = "Aucun résultat pour \"${widget.searchQuery}\".";

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.filter_list_off,
                      size: 80, color: Colors.black26),
                  const SizedBox(height: 20),
                  Text(msg,
                      style:
                          const TextStyle(color: Colors.black45, fontSize: 16)),
                ],
              ),
            );
          }

          final clients = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.only(
                top: 20, left: 16, right: 16, bottom: 100),
            itemCount: clients.length,
            itemBuilder: (context, index) {
              final client = clients[index];
              final statusColor = _getStatusColor(client.statut);

              return Container(
                height: 72,
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFE6DD),
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
                    Container(
                      width: 12,
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15)),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(client.nom,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black87),
                                overflow: TextOverflow.ellipsis),
                            if (client.entreprise.isNotEmpty)
                              Text(client.entreprise,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 90,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE0CDB2),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
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
    if (statut == 'Fidèle') return const Color(0xFF2A36FF);
    if (statut == 'Occasionnel') return const Color(0xFFFF0000);
    return Colors.grey;
  }
}
