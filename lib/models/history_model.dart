class HistoriqueModel {

  /// ======================
  /// AJOUT D’UN ÉVÉNEMENT
  /// ======================
  static Future<int> addHistorique(
    db,
    String lib,
    String type,
    String date,
  ) async {
    return await db.rawInsert(
      '''
      INSERT INTO historiques (lib, type, date)
      VALUES (?, ?, ?)
      ''',
      [lib, type, date],
    );
  }

  /// ======================
  /// LISTER HISTORIQUES
  /// ======================
  static Future<List<Map<String, dynamic>>> getAll(db) async {
    return await db.rawQuery(
      '''
      SELECT * FROM historiques
      ORDER BY date DESC
      '''
    );
  }
}