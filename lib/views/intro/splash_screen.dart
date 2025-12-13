import 'package:flutter/material.dart';
import 'welcome_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// On utilise TickerProviderStateMixin pour gérer des animations plus complexes
class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // 1. Configuration de l'animation
    // Elle dure 1.5 secondes et se répète (reverse: true fait l'aller-retour)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    // 2. Animation d'échelle (effet de pulsation)
    // Le logo va grossir de 1.0x à 1.1x sa taille
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // 3. Animation d'opacité (apparition progressive au tout début)
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        // L'apparition se fait sur les premiers 50% du premier cycle
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    // 4. Navigation après 4 secondes
    Future.delayed(const Duration(seconds: 4), () {
      // On arrête l'animation avant de changer de page pour éviter les fuites de mémoire
      _controller.stop(); 
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomePage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // On récupère la largeur de l'écran pour adapter la taille du logo
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      //couleur de fond Beige exacte
      backgroundColor: const Color(0xFFE6D6C4), 
      body: Center(
        // FadeTransition gère l'apparition en fondu
        child: FadeTransition(
          opacity: _opacityAnimation,
          // ScaleTransition gère l'effet de pulsation
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Logo
                Image.asset(
                  'assets/logo.png',
                  // Le logo prendra 60% de la largeur de l'écran
                  width: screenWidth * 0.6, 
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 30),
                // Texte "FAST CRM" en Bleu Nuit
                const Text(
                  "FAST CRM",
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: Color(0xFF0F2C59), 
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}