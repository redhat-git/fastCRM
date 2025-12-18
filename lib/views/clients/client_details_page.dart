import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // NOUVEAU
import '../../controllers/gestionnaire.dart';
import '../../models/client_model.dart';
import 'widgets/client_form_page.dart';

class ClientDetailsPage extends StatelessWidget {
  final Client client;
  const ClientDetailsPage({super.key, required this.client});

  // --- ACTIONS TÉLÉPHONE & EMAIL ---
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri =
        Uri(scheme: 'tel', path: phoneNumber.replaceAll(' ', ''));
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  Future<void> _sendEmail(String email) async {
    final Uri launchUri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFFD6C0A6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: const [
              Icon(Icons.close),
              SizedBox(width: 10),
              Text("Suppression en cours",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
            ]),
            const SizedBox(height: 15),
            const Text(
                "La suppression d’un client est définitive voulez vous quand meme continuer",
                textAlign: TextAlign.center),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.green, width: 2)),
                  onPressed: () async {
                    await Gestionnaire.supprimerClient(client.id!);
                    if (context.mounted) {
                      Navigator.pop(ctx);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("oui",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red, width: 2)),
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text("Non",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ],
            )
          ],
        ),
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
            onPressed: () => Navigator.pop(context)),
        title: const Text("Page client",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22)),
        actions: [
          IconButton(
              icon: const Icon(Icons.edit_outlined, color: Colors.black),
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ClientFormPage(client: client)));
                if (context.mounted) Navigator.pop(context);
              }),
          IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.black),
              onPressed: () => _showDeleteDialog(context)),
        ],
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.85,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFF3E9DD),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: const Color(0xFF2A36FF), width: 3),
          ),
          child: Column(
            children: [
              _buildInfoPill("Nom:", client.nom),
              const SizedBox(height: 15),
              _buildInfoPill("type de client :", "Professionnel"),
              const SizedBox(height: 15),
              _buildInfoPill("Entreprise:", client.entreprise),
              const SizedBox(height: 15),

              // BLOC CONTACT INTERACTIF
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8D6BF).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Contact:",
                        style: TextStyle(color: Colors.grey, fontSize: 16)),
                    const SizedBox(height: 8),

                    // TELEPHONE CLIQUABLE
                    InkWell(
                      onTap: () => _makePhoneCall(phone),
                      child: Row(
                        children: [
                          const Icon(Icons.phone,
                              size: 20, color: Color(0xFF2A36FF)),
                          const SizedBox(width: 10),
                          Text(phone,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  decoration: TextDecoration.underline)),
                        ],
                      ),
                    ),
                    const Text("Mobile",
                        style: TextStyle(fontSize: 12, color: Colors.grey)),

                    const SizedBox(height: 12),

                    // EMAIL CLIQUABLE
                    if (email.isNotEmpty)
                      InkWell(
                        onTap: () => _sendEmail(email),
                        child: Row(
                          children: [
                            const Icon(Icons.email,
                                size: 20, color: Color(0xFF2A36FF)),
                            const SizedBox(width: 10),
                            Expanded(
                                child: Text(email,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        decoration: TextDecoration.underline),
                                    overflow: TextOverflow.ellipsis)),
                          ],
                        ),
                      ),
                    if (email.isNotEmpty)
                      const Text("E-mail",
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Statut
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                decoration: BoxDecoration(
                    color: const Color(0xFFE8D6BF).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Statut du client :",
                            style: TextStyle(color: Colors.grey, fontSize: 16)),
                        Text(client.statut,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ],
                    ),
                    Container(
                        width: 50,
                        height: 35,
                        decoration: BoxDecoration(
                            color: _getStatusColor(client.statut),
                            borderRadius: BorderRadius.circular(8)))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String statut) {
    if (statut == 'Fidèle') return const Color(0xFF2A36FF);
    if (statut == 'Occasionnel') return const Color(0xFFFF0000);
    return Colors.grey;
  }

  Widget _buildInfoPill(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: BoxDecoration(
          color: const Color(0xFFE8D6BF).withOpacity(0.6),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Text(value,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
        ],
      ),
    );
  }
}
