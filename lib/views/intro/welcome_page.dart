import 'package:flutter/material.dart';
import '../auth/signup_page.dart';
import '../auth/login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Hauteur de l'écran
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFD6C0A6), // Beige un peu plus foncé du haut
      body: Stack(
        children: [
          // Logo en haut
          Positioned(
            top: size.height * 0.25,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'), // Votre logo
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          
          // La partie basse beige clair avec la courbe
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: size.height * 0.55,
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Color(0xFFEDE2D0), // Beige clair
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "fastCRM,",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Crée ton compte pour découvrir toutes nos fonctionnalités, personnaliser ton expérience et accéder à un espace pensé pour te simplifier la vie.",
                    style: TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
                  ),
                  const Spacer(),
                  
                  // Les deux boutons côte à côte
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupPage())),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text("S'inscrire", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage())),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text("Se connecter", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}