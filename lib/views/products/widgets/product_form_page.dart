import 'package:flutter/material.dart';
import '../../../models/product_model.dart';

class ProductFormPage extends StatefulWidget {
  final ProductModel? product;
  const ProductFormPage({super.key, this.product});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _nomController = TextEditingController();
  final _prixController = TextEditingController();
  final _stockController = TextEditingController();
  final _descController = TextEditingController();
  String categorie = "Service";

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _nomController.text = widget.product!.nom;
      _prixController.text = widget.product!.prix.toString();
      _stockController.text = widget.product!.stock.toString();
      _descController.text = widget.product!.description;
      categorie = widget.product!.categorie;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8D6BF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8D6BF),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text(widget.product == null ? "Nouveau Produit" : "Modifier Produit", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.check, color: Colors.black, size: 30), onPressed: () => Navigator.pop(context))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
               padding: const EdgeInsets.symmetric(horizontal: 12),
               decoration: BoxDecoration(color: const Color(0xFFE0CDB2), borderRadius: BorderRadius.circular(15)),
               child: DropdownButtonHideUnderline(
                 child: DropdownButton<String>(
                   value: categorie,
                   isExpanded: true,
                   items: ["Service", "Logiciel", "Matériel", "Support"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                   onChanged: (v) => setState(() => categorie = v!),
                 ),
               ),
             ),
            const SizedBox(height: 20),
            _buildInput("Nom du produit", _nomController),
            _buildInput("Prix (FCFA)", _prixController, isNumber: true),
            _buildInput("Stock disponible", _stockController, isNumber: true),
            const SizedBox(height: 20),
            TextField(
              controller: _descController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Description",
                alignLabelWithHint: true,
                filled: true, fillColor: const Color(0xFFF0E6DA),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController controller, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          filled: true, fillColor: const Color(0xFFF0E6DA),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}