import 'package:flutter/material.dart';
import '../home/home_screen.dart';

class PinCodePage extends StatefulWidget {
  // On ajoute un paramètre pour recevoir le nom
  // S'il est vide, on mettra un nom par défaut
  final String userName;
  const PinCodePage({super.key, this.userName = "Utilisateur"});
  @override
  State<PinCodePage> createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  String code = "";

    void _onKeyPress(String value) {
    if (code.length < 6) {
      setState(() => code += value);
    }
    // Simulation: si le code est long de 6 chiffres, on entre
    if (code.length == 6) {
      Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(builder: (_) => const HomeScreen()), 
        (route) => false
      );
    }
  }

  void _onDelete() {
    if (code.isNotEmpty) {
      setState(() => code = code.substring(0, code.length - 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDE2D0),

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
          Center(child: Opacity(opacity: 0.05, child: Image.asset('assets/logo.jpg', width: 300))),
          Column(
            children: [
              const SizedBox(height: 20),
              // Titre Dynamique
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 32, color: Colors.black),
                  children: [
                    const TextSpan(text: "Bonjour ", style: TextStyle(fontWeight: FontWeight.bold)),
                    // On utilise widget.userName ici
                    TextSpan(text: "${widget.userName} ,", style: const TextStyle(fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              
              const Text("Entrer le code d’accès rapide.", style: TextStyle(color: Colors.red, fontSize: 16)),
              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 20, height: 20,
                    decoration: BoxDecoration(
                      color: index < code.length ? const Color(0xFF4A4A4A) : const Color(0xFF4A4A4A).withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              
              const Spacer(),
              
              // Clavier Numérique
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
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
                        const Icon(Icons.fingerprint, size: 50, color: Colors.black), // Icone empreinte
                        _buildBtn("0"),
                        IconButton(
                          icon: const Icon(Icons.backspace_outlined, size: 30),
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
        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}