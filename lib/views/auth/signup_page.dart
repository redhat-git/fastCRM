import 'package:flutter/material.dart';
import 'signup_confirm_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Variable pour savoir si une photo est simulée
  bool _hasSelectedPhoto = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6D6C4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("S’inscrire",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text(
                "Veuillez inscrire vos informations pour la création de votre compte.",
                style: TextStyle(fontSize: 16, color: Colors.black54)),
            const SizedBox(height: 30),

            // Avatar (Cliquable)
            Center(
              child: GestureDetector(
                onTap: () {
                  // Simulation : On clique, la photo est "choisie"
                  setState(() => _hasSelectedPhoto = true);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Photo sélectionnée !"),
                      duration: Duration(seconds: 1)));
                },
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        // Si une photo est choisie, on affiche une image (placeholder ou réelle)
                        image: _hasSelectedPhoto
                            ? const DecorationImage(
                                image: AssetImage('assets/logo.png'),
                                fit: BoxFit
                                    .cover) // On utilise le logo comme exemple de photo
                            : null,
                      ),
                      child: _hasSelectedPhoto
                          ? null // Plus d'icône si photo
                          : const Icon(Icons.person_outline,
                              size: 50, color: Colors.black54),
                    ),
                    CircleAvatar(
                      backgroundColor: _hasSelectedPhoto
                          ? Colors.green
                          : Colors.black, // Change de couleur si sélectionné
                      radius: 15,
                      child: Icon(_hasSelectedPhoto ? Icons.check : Icons.add,
                          color: Colors.white, size: 18),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildTextField("Nom d’utilisateur", _nameController),
            const SizedBox(height: 20),
            _buildTextField("Adresse e-mail", _emailController),
            const SizedBox(height: 20),
            _buildTextField("Numéro de téléphone", _phoneController),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // On transmet l'info de la photo (true/false)
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => SignupConfirmPage(
                                name: _nameController.text,
                                email: _emailController.text,
                                phone: _phoneController.text,
                                hasPhoto: _hasSelectedPhoto, // <-- NOUVEAU
                              )));
                },
                // ... style du bouton ...
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text("S’ inscrire",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ... _buildTextField reste pareil ...
  Widget _buildTextField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
      ),
    );
  }
}
