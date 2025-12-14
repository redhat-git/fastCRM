import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {

    await db.execute(
      '''
      CREATE TABLE gestionnaires (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        mdp TEXT NOT NULL
      )
      '''
    );

    await db.execute(
      '''
      CREATE TABLE clients (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        entreprise TEXT NOT NULL,
        statut TEXT NOT NULL,
        contact TEXT NOT NULL
      )
      '''
    );

    await db.execute(
      '''
      CREATE TABLE historiques (
        idhist INTEGER PRIMARY KEY AUTOINCREMENT,
        lib TEXT NOT NULL,
        type TEXT NOT NULL,
        date TEXT NOT NULL
      )
      '''
    );
  }


  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
