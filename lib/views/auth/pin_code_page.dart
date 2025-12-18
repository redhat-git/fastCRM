import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart'; // Biométrie
import 'package:shared_preferences/shared_preferences.dart'; // Sauvegarde préférence
import '../../controllers/gestionnaire.dart';
import '../main_screen.dart';

class PinCodePage extends StatefulWidget {
  final String userName;
  const PinCodePage({super.key, this.userName = "Utilisateur"});
  @override
  State<PinCodePage> createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  String code = "";
  bool _isLoading = false;
  final LocalAuthentication auth = LocalAuthentication();

  void _onKeyPress(String value) async {
    if (code.length < 6) {
      setState(() => code += value);
    }

    // Quand le code est complet (6 chiffres)
    if (code.length == 6 && !_isLoading) {
      setState(() => _isLoading = true);

      try {
        // 1. Enregistrement en Base de Données
        await Gestionnaire.enregistrerGestionnaire(code);

        // 2. Proposer la configuration de l'empreinte
        if (mounted) {
          await _askToEnableBiometrics();
        }
      } catch (e) {
        setState(() {
          code = "";
          _isLoading = false;
        });
        if (mounted)
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Erreur: $e")));
      }
    }
  }

  // --- NOUVELLE FONCTION : CONFIGURATION BIOMÉTRIE ---
  Future<void> _askToEnableBiometrics() async {
    try {
      bool canCheck = await auth.canCheckBiometrics;
      if (!canCheck) {
        _goToHome(); // Pas de capteur, on passe
        return;
      }

      // Afficher une boite de dialogue
      bool userWantsBiometrics = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => AlertDialog(
              title: const Text("Activer l'empreinte ?"),
              content: const Text(
                  "Voulez-vous utiliser votre empreinte digitale pour vous connecter plus rapidement la prochaine fois ?"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text("Non, merci")),
                ElevatedButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    child: const Text("Activer")),
              ],
            ),
          ) ??
          false;

      if (userWantsBiometrics) {
        // Vérifier l'empreinte pour confirmer
        bool authenticated = await auth.authenticate(
          localizedReason:
              'Veuillez scanner votre empreinte pour confirmer l\'activation',
          options: const AuthenticationOptions(
              stickyAuth: true, biometricOnly: true),
        );

        if (authenticated) {
          // SAUVEGARDE DE LA PRÉFÉRENCE
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('biometrics_enabled', true);

          if (mounted)
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Empreinte activée !")));
        }
      }

      _goToHome();
    } catch (e) {
      print("Erreur bio setup: $e");
      _goToHome();
    }
  }

  void _goToHome() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
        (route) => false);
  }

  void _onDelete() {
    if (code.isNotEmpty)
      setState(() => code = code.substring(0, code.length - 1));
  }

  @override
  Widget build(BuildContext context) {
    // ... (Le reste du code UI reste identique à votre version précédente)
    // Assurez-vous juste de garder la structure Scaffold, AppBar, Body, Clavier
    return Scaffold(
      backgroundColor: const Color(0xFFEDE2D0),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context))),
      body: Stack(
        children: [
          Center(
              child: Opacity(
                  opacity: 0.05,
                  child: Image.asset('assets/logo.png', width: 300))),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            Column(
              children: [
                const SizedBox(height: 20),
                RichText(
                    text: TextSpan(
                        style:
                            const TextStyle(fontSize: 32, color: Colors.black),
                        children: [
                      const TextSpan(
                          text: "Bonjour ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: "${widget.userName},",
                          style: const TextStyle(fontWeight: FontWeight.normal))
                    ])),
                const SizedBox(height: 50),
                const Text("Définissez votre code d’accès (6 chiffres).",
                    style: TextStyle(color: Colors.red, fontSize: 16)),
                const SizedBox(height: 30),
                // Indicateurs (points)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      6,
                      (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: index < code.length
                                  ? const Color(0xFF4A4A4A)
                                  : const Color(0xFF4A4A4A).withOpacity(0.3),
                              shape: BoxShape.circle))),
                ),
                const Spacer(),
                // Clavier
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
                            const Icon(Icons.fingerprint,
                                size: 50, color: Colors.transparent),
                            _buildBtn("0"),
                            IconButton(
                                icon: const Icon(Icons.backspace_outlined,
                                    size: 30),
                                onPressed: _onDelete)
                          ]),
                    ],
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildRow(String v1, String v2, String v3) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [_buildBtn(v1), _buildBtn(v2), _buildBtn(v3)]);
  Widget _buildBtn(String val) => TextButton(
      onPressed: () => _onKeyPress(val),
      child: Text(val,
          style: const TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black)));
}
