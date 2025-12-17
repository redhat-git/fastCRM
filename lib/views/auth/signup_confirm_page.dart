import 'package:flutter/material.dart';
import 'signup_success_page.dart';

class SignupConfirmPage extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final bool hasPhoto;

  const SignupConfirmPage({
    super.key, 
    required this.name, 
    required this.email, 
    required this.phone,
    required this.hasPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6D6C4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Finalisation", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Veuillez vérifier vos informations, puis confirmer pour terminer la création de votre compte.", style: TextStyle(fontSize: 16, color: Colors.black54)),
            const SizedBox(height: 40),

            // RAPPEL AVATAR
            Center(
              child: Container(
                width: 100, height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5), 
                  shape: BoxShape.circle,
                  image: hasPhoto 
                      ? const DecorationImage(image: AssetImage('assets/logo.png'), fit: BoxFit.cover)
                      : null
                ),
                child: hasPhoto 
                    ? null
                    : const Icon(Icons.person_outline, size: 50, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 40),

            // INFO CARDS
            _infoCard(name.isEmpty ? "Nom inconnu" : name),
            const SizedBox(height: 15),
            _infoCard(email.isEmpty ? "Email inconnu" : email),
            const SizedBox(height: 15),
            _infoCard(phone.isEmpty ? "Tel inconnu" : phone),

            const Spacer(),

            // BOUTON CONFIRMER
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => SignupSuccessPage(
                    name: name,
                    hasPhoto: hasPhoto
                  )));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text("Confirmer", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}