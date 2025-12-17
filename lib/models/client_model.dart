class Client {
  final int? id;
  final String nom;
  final String entreprise;
  final String statut;
  final String contact;

  Client({
    this.id,
    required this.nom,
    required this.entreprise,
    required this.statut,
    required this.contact,
  });

  //converti pour format bdd
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'entreprise': entreprise,
      'statut': statut,
      'contact': contact,
    };
  }

  //conv pour dart
  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'],
      nom: map['nom'],
      entreprise: map['entreprise'],
      statut: map['statut'],
      contact: map['contact'],
    );
  }

  // ====== MÉTHODES STATIQUES ======

  static Future<int> addCli(
    db,
    String nom,
    String entreprise,
    String statut,
    String contact,
  ) async {
    return await db.rawInsert(
      '''
      INSERT INTO clients (nom, entreprise, statut, contact)
      VALUES (?, ?, ?, ?)
      ''',
      [nom, entreprise, statut, contact],
    );
  }

  static Future<List<Map<String, dynamic>>> getAll(db) async {
    return await db.rawQuery('''
      SELECT * FROM clients
      ORDER BY nom ASC
      ''');
  }

  static Future<int> updateCli(
    db,
    int id,
    String nom,
    String entreprise,
    String statut,
    String contact,
  ) async {
    return await db.rawUpdate(
      '''
      UPDATE clients
      SET nom = ?, entreprise = ?, statut = ?, contact = ?
      WHERE id = ?
      ''',
      [nom, entreprise, statut, contact, id],
    );
  }

  static Future<int> deleteCli(db, int id) async {
    return await db.rawDelete(
      '''
      DELETE FROM clients
      WHERE id = ?
      ''',
      [id],
    );
  }
}
