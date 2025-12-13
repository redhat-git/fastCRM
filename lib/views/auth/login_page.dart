import 'package:flutter/material.dart';
import '../main_screen.dart';
import 'signup_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // On récupère la taille de l'écran
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              // LOGO
              Container(
                height: 150,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo.jpg'), 
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              
              // Texte de bienvenue
              Text(
                "Bienvenue sur Fast CRM",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Gérez vos clients avec rapidité et élégance.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 50),

              // CHAMPS DE TEXTE
              const TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Mot de passe",
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // BOUTON
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => const MainScreen()));
                },
                child: const Text("SE CONNECTER"),
              ),
              
              const Spacer(),
              
              // LIEN INSCRIPTION
              TextButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const SignupPage())),
                child: Text(
                  "Créer un nouveau compte",
                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}