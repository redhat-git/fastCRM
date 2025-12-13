import 'package:flutter/material.dart';
import 'pin_code_page.dart';

class SignupSuccessPage extends StatelessWidget {
  final String name;
  final bool hasPhoto; // <-- NOUVEAU

  const SignupSuccessPage({super.key, required this.name, required this.hasPhoto}); // <-- NOUVEAU

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6D6C4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(fontSize: 28, color: Colors.black, fontFamily: 'Arial'),
                  children: [
                    const TextSpan(text: "Bienvenue parmi\nnous, ", style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: "$name.", style: const TextStyle(fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
              const SizedBox(height: 50),

              // Illustration (Grande bulle avec la photo)
              Container(
                width: 200, height: 200,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  shape: BoxShape.circle,
                  // Affichage conditionnel de l'image
                  image: hasPhoto 
                      ? const DecorationImage(image: AssetImage('assets/logo.jpg'), fit: BoxFit.cover)
                      : null
                ),
                child: hasPhoto 
                    ? null 
                    : const Icon(Icons.image_outlined, size: 80, color: Colors.black87),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // C'EST ICI : On transmet le nom à la page PIN
                    Navigator.push(context, MaterialPageRoute(builder: (_) => PinCodePage(userName: name)));
                  },
                  
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text("Continuer", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}