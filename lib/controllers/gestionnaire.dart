//gestionnaire.dart
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:fast_crm/models/client_model.dart';
import 'package:fast_crm/models/history_model.dart';
import '../database/database_helper.dart';

class Gestionnaire {
  static final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  static String _hashMdp(String mdp) {
    final bytes = utf8.encode(mdp);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

//------------------GESTIONNAIRE------------------------

  //meth pour inscription
  static Future<int> enregistrerGestionnaire(
    String mdp,
  ) async {
    final db = await _dbHelper.database;
    final mdpHash = _hashMdp(mdp);

    return await db.rawInsert(
      '''
      INSERT INTO gestionnaires (mdp)
      VALUES (?)
      ''',
      [mdpHash],
    );
  }

  // meth pour connexion
  static Future<bool> verifierMdp(String mdp) async {
    final db = await _dbHelper.database;
    final mdpHash = _hashMdp(mdp);

    final result = await db.rawQuery('''
      SELECT mdp
      FROM gestionnaires
      LIMIT 1
      ''');

    if (result.isEmpty) {
      return false;
    }

    final mdpStocke = result.first['mdp'];

    return mdpHash == mdpStocke;
  }

//---------------------FIN GESTIONNAIRE---------------------

// =========================
  // AJOUT CLIENT
  // =========================
  static Future<int> ajouterClient({
    required String nom,
    required String entreprise,
    required String statut,
    required String contact,
  }) async {
    if (nom.isEmpty || contact.isEmpty) {
      throw Exception("Nom et contact obligatoires");
    }

    final db = await _dbHelper.database;

    final id = await Client.addCli(
      db,
      nom,
      entreprise,
      statut,
      contact,
    );

    await HistoriqueModel.addHistorique(
      db,
      "Ajout du client $nom",
      "AJOUT",
      DateTime.now().toIso8601String(),
    );

    return id;
  }

  // =========================
  // MODIFICATION CLIENT
  // =========================
  static Future<void> modifierClient({
    required int id,
    required String nom,
    required String entreprise,
    required String statut,
    required String contact,
  }) async {
    if (id <= 0) {
      throw Exception("ID client invalide");
    }

    final db = await _dbHelper.database;

    final rows = await Client.updateCli(
      db,
      id,
      nom,
      entreprise,
      statut,
      contact,
    );

    if (rows == 0) {
      throw Exception("Client non trouvé");
    }

    await HistoriqueModel.addHistorique(
      db,
      "Modification du client $nom (ID $id)",
      "MODIFICATION",
      DateTime.now().toIso8601String(),
    );
  }

  // =========================
  // SUPPRESSION CLIENT
  // =========================
  static Future<void> supprimerClient(int id) async {
    if (id <= 0) {
      throw Exception("ID client invalide");
    }

    final db = await _dbHelper.database;

    final rows = await Client.deleteCli(db, id);

    if (rows == 0) {
      throw Exception("Client non trouvé");
    }

    await HistoriqueModel.addHistorique(
      db,
      "Suppression du client ID $id",
      "SUPPRESSION",
      DateTime.now().toIso8601String(),
    );
  }
}
