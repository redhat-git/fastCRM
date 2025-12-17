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

            // SÉLECTION PHOTO (Simulation)
            Center(
              child: GestureDetector(
                onTap: () {
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
                        image: _hasSelectedPhoto
                            ? const DecorationImage(
                                image: AssetImage('assets/logo.png'), // Photo simulée
                                fit: BoxFit.cover)
                            : null,
                      ),
                      child: _hasSelectedPhoto
                          ? null
                          : const Icon(Icons.person_outline,
                              size: 50, color: Colors.black54),
                    ),
                    CircleAvatar(
                      backgroundColor: _hasSelectedPhoto
                          ? Colors.green
                          : Colors.black,
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
                  // Navigation vers confirmation
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => SignupConfirmPage(
                                name: _nameController.text,
                                email: _emailController.text,
                                phone: _phoneController.text,
                                hasPhoto: _hasSelectedPhoto,
                              )));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Bouton noir spécifique à cette page
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text("S’inscrire",
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