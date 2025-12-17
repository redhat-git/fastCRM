import 'package:flutter/material.dart';
import '../../../../controllers/gestionnaire.dart';
import '../../../../models/client_model.dart';

class ClientFormPage extends StatefulWidget {
  final Client? client;
  const ClientFormPage({super.key, this.client});

  @override
  State<ClientFormPage> createState() => _ClientFormPageState();
}

class _ClientFormPageState extends State<ClientFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _entrepriseController = TextEditingController();
  final _telController = TextEditingController();
  final _emailController = TextEditingController(); // Fait partie du contact

  // Valeurs par défaut
  String typeClient = "Entreprise";
  String statut = "Fidèle";

  @override
  void initState() {
    super.initState();
    if (widget.client != null) {
      _nomController.text = widget.client!.nom;
      _entrepriseController.text = widget.client!.entreprise;
      statut = widget.client!.statut;

      // Parsing simple (à adapter selon votre logique de stockage "Tel|Email")
      if (widget.client!.contact.contains('|')) {
        final parts = widget.client!.contact.split('|');
        _telController.text = parts[0];
        if (parts.length > 1) _emailController.text = parts[1];
      } else {
        _telController.text = widget.client!.contact;
      }
    }
  }

  Future<void> _saveData() async {
    if (!_formKey.currentState!.validate()) return;

    // Concaténation pour le backend
    String contactFull = "${_telController.text}|${_emailController.text}";

    try {
      if (widget.client == null) {
        await Gestionnaire.ajouterClient(
          nom: _nomController.text,
          entreprise: _entrepriseController.text,
          statut: statut,
          contact: contactFull,
        );
      } else {
        await Gestionnaire.modifierClient(
          id: widget.client!.id!,
          nom: _nomController.text,
          entreprise: _entrepriseController.text,
          statut: statut,
          contact: contactFull,
        );
      }
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Erreur: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFE8D6BF), // Fond Beige global (cf Header maquette)

      // --- HEADER ---
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8D6BF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          widget.client == null ? "Ajouter client" : "Modifier client",
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.black, size: 28),
            onPressed: _saveData,
          ),
          const SizedBox(width: 10),
        ],
      ),

      // --- CORPS DU FORMULAIRE ---
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFDFBF7), // Fond blanc cassé pour la zone de saisie
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // DROPDOWNS CÔTE À CÔTE
            Row(
              children: [
                // Type de client
                Expanded(
                  child: _buildDropdownBlock("type de client", typeClient,
                      ["Entreprise", "Particulier", "Professionnel"], (val) {
                    setState(() => typeClient = val!);
                  }),
                ),
                const SizedBox(width: 15),
                // Statut
                Expanded(
                  child: _buildDropdownBlock(
                      "Statut", statut, ["Fidèle", "Neutre", "Occasionnel"],
                      (val) {
                    setState(() => statut = val!);
                  }),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // CHAMPS DE SAISIE (Style souligné)
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildUnderlineInput(
                      "Nom", Icons.person_outline, _nomController),
                  const SizedBox(height: 20),
                  _buildUnderlineInput(
                      "Téléphone",
                      Icons.perm_contact_calendar_outlined,
                      _telController), // Icone calendrier/contact proche maquette
                  const SizedBox(height: 20),
                  _buildUnderlineInput("Email", null,
                      _emailController), // Pas d'icone sur la maquette pour Email
                  const SizedBox(height: 20),
                  _buildUnderlineInput(
                      "Contact de l’entreprise",
                      Icons.business_outlined,
                      _entrepriseController), // Ou Nom entreprise
                  const SizedBox(height: 20),
                  // Champs supplémentaires maquette (Téléphone 1, 2...) si besoin
                  // _buildUnderlineInput("Téléphone", null, TextEditingController()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour les blocs Dropdown beiges (arrondis)
  Widget _buildDropdownBlock(String label, String value, List<String> items,
      ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE6D6C4), // Beige plus foncé (cf maquette)
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(color: Colors.black54, fontSize: 12)),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isDense: true,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down,
                  color: Color(0xFF1A3B6E)),
              style: const TextStyle(
                  color: Color(0xFF1A3B6E),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  // Widget pour les champs soulignés (Style "Client craft.png")
  Widget _buildUnderlineInput(
      String hint, IconData? icon, TextEditingController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (icon != null) ...[
          Icon(icon, color: const Color(0xFFC7B299), size: 28),
          const SizedBox(width: 15),
        ] else ...[
          // Si pas d'icone, on garde l'alignement ou pas selon maquette.
          // La maquette "Email" n'a pas d'icone mais est alignée avec le texte.
          const SizedBox(width: 43),
        ],
        Expanded(
          child: TextFormField(
            controller: controller,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            decoration: InputDecoration(
              labelText: hint,
              labelStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
              contentPadding: const EdgeInsets.only(bottom: 8),
              isDense: true,
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFC7B299), width: 2),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF1A3B6E), width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
