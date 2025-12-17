import 'package:flutter/material.dart';
// Les imports vers le dossier AUTH (remonter d'un niveau ../)
import '../auth/signup_page.dart';
import '../auth/login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFD6C0A6), // Beige foncé haut
      body: Stack(
        children: [
          // Logo en haut (Positionné à 25% de la hauteur)
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
                    image: AssetImage('assets/logo.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          
          // Partie basse beige clair (Courbée)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: size.height * 0.55, // Prend 55% du bas
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Color(0xFFEDE2D0), // Beige clair bas
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
                  
                  // BOUTONS CÔTE À CÔTE
                  Row(
                    children: [
                      // Bouton Inscription
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
                      // Bouton Connexion
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