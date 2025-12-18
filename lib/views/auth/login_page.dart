import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/gestionnaire.dart';
import '../main_screen.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _passController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricsPreference();
  }

  // Vérifier si l'utilisateur a activé la biométrie lors de l'inscription
  Future<void> _checkBiometricsPreference() async {
    final prefs = await SharedPreferences.getInstance();
    bool isEnabled = prefs.getBool('biometrics_enabled') ?? false;

    if (isEnabled) {
      _authenticate();
    }
  }

  Future<void> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Connexion rapide par empreinte',
        options:
            const AuthenticationOptions(stickyAuth: true, biometricOnly: true),
      );

      if (authenticated && mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const MainScreen()));
      }
    } catch (e) {
      // Erreur silencieuse (l'utilisateur peut toujours taper son code)
    }
  }

  Future<void> _login() async {
    if (_passController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Veuillez entrer votre code"),
          backgroundColor: Colors.orange));
      return;
    }

    setState(() => _isLoading = true);
    try {
      bool isValid = await Gestionnaire.verifierMdp(_passController.text);
      if (isValid) {
        if (mounted)
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const MainScreen()));
      } else {
        if (mounted)
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Code incorrect"), backgroundColor: Colors.red));
      }
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Erreur: $e")));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFE8D6BF),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Container(
                height: 150,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/logo.png'),
                      fit: BoxFit.contain),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "Bon retour !",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              const SizedBox(height: 10),
              const Text(
                "Entrez votre code d'accès.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 50),

              // Champ Mot de passe (Code PIN)
              TextField(
                controller: _passController,
                obscureText: true,
                keyboardType:
                    TextInputType.number, // Clavier numérique pour le PIN
                maxLength: 6, // Limite à 6 chiffres
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 24,
                    letterSpacing: 5,
                    fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  labelText: "Code PIN",
                  prefixIcon: Icon(Icons.lock_outline),
                  counterText: "", // Cache le compteur 0/6
                ),
              ),
              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: _isLoading ? null : _login,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("SE CONNECTER"),
              ),

              const SizedBox(height: 20),

              // Bouton Empreinte
              IconButton(
                icon: const Icon(Icons.fingerprint,
                    size: 60, color: Color(0xFF1A3B6E)),
                onPressed: _authenticate,
                tooltip: "Utiliser l'empreinte",
              ),

              const Spacer(),
              TextButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SignupPage())),
                child: Text(
                  "Créer un nouveau compte",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
