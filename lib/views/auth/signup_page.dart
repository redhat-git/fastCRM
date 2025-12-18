import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/gestionnaire.dart';
import '../main_screen.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String code = "";
  bool _isLoading = false;

  // Outils pour la biométrie
  final LocalAuthentication auth = LocalAuthentication();

  // Gestion du clavier numérique
  void _onKeyPress(String value) async {
    if (code.length < 6) {
      setState(() => code += value);
    }

    // Une fois le code à 6 chiffres entré
    if (code.length == 6 && !_isLoading) {
      setState(() => _isLoading = true);

      try {
        // 1. Enregistrement en Base de Données (Seul le MDP est stocké)
        await Gestionnaire.enregistrerGestionnaire(code);

        // 2. Proposer la configuration de l'empreinte
        if (mounted) {
          await _askToEnableBiometrics();
        }
      } catch (e) {
        setState(() {
          code = ""; // Reset en cas d'erreur
          _isLoading = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Erreur: $e")));
        }
      }
    }
  }

  void _onDelete() {
    if (code.isNotEmpty) {
      setState(() => code = code.substring(0, code.length - 1));
    }
  }

  // --- LOGIQUE BIOMÉTRIE ---
  Future<void> _askToEnableBiometrics() async {
    try {
      bool canCheck = await auth.canCheckBiometrics;
      if (!canCheck) {
        _goToHome(); // Pas de capteur, on termine
        return;
      }

      // Demander à l'utilisateur
      bool userWantsBiometrics = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => AlertDialog(
              backgroundColor: const Color(0xFFE8D6BF),
              title: const Text("Activer l'empreinte ?"),
              content: const Text(
                  "Voulez-vous utiliser votre empreinte digitale pour vous connecter plus rapidement la prochaine fois ?"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text("Non, merci",
                        style: TextStyle(color: Colors.black))),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A3B6E)),
                    onPressed: () => Navigator.pop(ctx, true),
                    child: const Text("Activer",
                        style: TextStyle(color: Colors.white))),
              ],
            ),
          ) ??
          false;

      if (userWantsBiometrics) {
        // Vérification de sécurité
        bool authenticated = await auth.authenticate(
          localizedReason:
              'Veuillez scanner votre empreinte pour confirmer l\'activation',
          options: const AuthenticationOptions(
              stickyAuth: true, biometricOnly: true),
        );

        if (authenticated) {
          // Sauvegarde de la préférence
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('biometrics_enabled', true);

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Empreinte activée avec succès !")));
          }
        }
      }

      _goToHome();
    } catch (e) {
      print("Erreur setup bio: $e");
      _goToHome();
    }
  }

  void _goToHome() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDE2D0), // Fond beige doux
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Logo en filigrane
          Center(
              child: Opacity(
                  opacity: 0.05,
                  child: Image.asset('assets/logo.png', width: 300))),

          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Création de compte",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Veuillez définir votre code d'accès unique à 6 chiffres.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),

                const SizedBox(height: 50),

                // Indicateurs (Points)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: index < code.length
                            ? const Color(0xFF1A3B6E)
                            : const Color(0xFF1A3B6E).withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),

                const Spacer(),

                // Clavier Numérique
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                  child: Column(
                    children: [
                      _buildRow("7", "8", "9"),
                      const SizedBox(height: 20),
                      _buildRow("4", "5", "6"),
                      const SizedBox(height: 20),
                      _buildRow("1", "2", "3"),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(
                              width: 60), // Espace vide à gauche du 0
                          _buildBtn("0"),
                          IconButton(
                            icon:
                                const Icon(Icons.backspace_outlined, size: 30),
                            onPressed: _onDelete,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildRow(String v1, String v2, String v3) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [_buildBtn(v1), _buildBtn(v2), _buildBtn(v3)],
    );
  }

  Widget _buildBtn(String val) {
    return TextButton(
      onPressed: () => _onKeyPress(val),
      child: Text(
        val,
        style: const TextStyle(
            fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}
