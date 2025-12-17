import 'package:flutter/material.dart';
import 'widgets/dashboard_chart.dart'; // Import du widget créé juste avant

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    // On utilise un Column pour empiler le Header et le Contenu
    return Column(
      children: [
        // --- HEADER PERSONNALISÉ (Tableau de bord) ---
        Container(
          padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 25),
          decoration: const BoxDecoration(
            color: Color(0xFFD6C0A6), // Beige foncé du haut
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          child: Column(
            children: [
              // Ligne supérieure (Titre App + Menu)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.flash_on, color: Color(0xFF0F2C59), size: 28),
                      SizedBox(width: 8),
                      Text(
                        "FastCRM", 
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          color: Color(0xFF0F2C59), 
                          fontSize: 22
                        )
                      ),
                    ],
                  ),
                  const Icon(Icons.menu, size: 30, color: Color(0xFF0F2C59)),
                ],
              ),
              const SizedBox(height: 30),
              
              // Onglets (Tableau de bord / Historique)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Onglet Actif
                  Column(
                    children: [
                      const Text(
                        "Tableau de bord", 
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          color: Color(0xFF0F2C59), 
                          fontSize: 16
                        )
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5), 
                        height: 3, 
                        width: 80, 
                        color: const Color(0xFF0F2C59)
                      )
                    ],
                  ),
                  const SizedBox(width: 30),
                  // Onglet Inactif
                  Column(
                    children: [
                      Text(
                        "Historique", 
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          color: Colors.white.withOpacity(0.6), 
                          fontSize: 16
                        )
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5), 
                        height: 3, 
                        width: 80, 
                        color: Colors.transparent
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),

        const SizedBox(height: 40),

        // --- APPEL DU WIDGET GRAPHIQUE ---
        const DashboardChart(),

        const SizedBox(height: 20),
        
        // Indicateur de pagination (petit point noir)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 8, 
              height: 8, 
              decoration: const BoxDecoration(
                color: Color(0xFF0F2C59), 
                shape: BoxShape.circle
              )
            ),
          ],
        )
      ],
    );
  }
}