import 'package:flutter/material.dart';
import 'clients/clients_list_page.dart';
import 'products/products_list_page.dart';
import 'analysis/analysis_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const ClientsListPage(),
    const ProductsListPage(),
    const AnalysisPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Le body change selon l'index
      body: _pages[_currentIndex],
      
      // Barre de navigation personnalisée
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))
          ]
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: Colors.white,
          selectedItemColor: Theme.of(context).primaryColor, // Bleu Fast CRM
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              activeIcon: Icon(Icons.people),
              label: "Clients"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2_outlined),
              activeIcon: Icon(Icons.inventory_2),
              label: "Produits"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined),
              activeIcon: Icon(Icons.analytics),
              label: "Analyse"
            ),
          ],
        ),
      ),
    );
  }
}