import 'package:flutter/material.dart';
import '../../../models/client_model.dart';

class ClientFormPage extends StatefulWidget {
  final ClientModel? client; // Si null = Ajout, sinon = Modification
  const ClientFormPage({super.key, this.client});

  @override
  State<ClientFormPage> createState() => _ClientFormPageState();
}

class _ClientFormPageState extends State<ClientFormPage> {
  final _nomController = TextEditingController();
  final _entrepriseController = TextEditingController();
  final _telController = TextEditingController();
  final _emailController = TextEditingController();
  
  String statut = "Fidèle";

  @override
  void initState() {
    super.initState();
    // Si on modifie, on remplit les champs
    if (widget.client != null) {
      _nomController.text = widget.client!.nom;
      _entrepriseController.text = widget.client!.entreprise;
      statut = widget.client!.statut;
      
      // Découpage du contact (Tel|Email)
      if (widget.client!.contact.contains('|')) {
        final parts = widget.client!.contact.split('|');
        _telController.text = parts[0];
        if (parts.length > 1) _emailController.text = parts[1];
      } else {
        _telController.text = widget.client!.contact;
      }
    }
  }

  void _saveData() {
    // Ici, on simule la sauvegarde
    // On combine Tel et Email
    String contactFull = "${_telController.text}|${_emailController.text}";
    print("Sauvegarde de : ${_nomController.text}, $contactFull");
    
    Navigator.pop(context); // Retour à la page précédente
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.client != null;
    return Scaffold(
      backgroundColor: const Color(0xFFE8D6BF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8D6BF),
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.close, color: Colors.black), onPressed: () => Navigator.pop(context)),
        title: Text(isEdit ? "Modifier client" : "Ajouter client", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.black, size: 30),
            onPressed: _saveData,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
             // Dropdown Statut
             Container(
               padding: const EdgeInsets.symmetric(horizontal: 12),
               decoration: BoxDecoration(color: const Color(0xFFE0CDB2), borderRadius: BorderRadius.circular(15)),
               child: DropdownButtonHideUnderline(
                 child: DropdownButton<String>(
                   value: statut,
                   isExpanded: true,
                   items: ["Fidèle", "Neutre", "Occasionnel"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                   onChanged: (v) => setState(() => statut = v!),
                 ),
               ),
             ),
             const SizedBox(height: 30),
             
             _buildInput(Icons.person_outline, "Nom", _nomController),
             _buildInput(Icons.business_outlined, "Entreprise", _entrepriseController),
             _buildInput(Icons.phone_outlined, "Téléphone", _telController),
             _buildInput(Icons.email_outlined, "Email", _emailController),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(IconData icon, String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color(0xFFC7B299)),
          labelText: hint,
          filled: false,
          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFC7B299))),
          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF1A3B6E), width: 2)),
        ),
      ),
    );
  }
}