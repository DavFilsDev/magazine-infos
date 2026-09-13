import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../modele/redacteur.dart';

class DatabaseManager {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'redacteurs.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE redacteurs(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nom TEXT,
            prenom TEXT,
            email TEXT
          )
        ''');
      },
    );
  }

  Future<List<Redacteur>> getAllRedacteurs() async {
    final db = await database;
    final maps = await db.query('redacteurs');
    return maps.map((m) => Redacteur.fromMap(m)).toList();
  }

  Future<int> insertRedacteur(Redacteur r) async {
    final db = await database;
    return await db.insert('redacteurs', r.toMap());
  }

  Future<int> updateRedacteur(Redacteur r) async {
    final db = await database;
    return await db.update(
      'redacteurs',
      r.toMap(),
      where: 'id = ?',
      whereArgs: [r.id],
    );
  }

  Future<int> deleteRedacteur(int id) async {
    final db = await database;
    return await db.delete('redacteurs', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAllRedacteurs() async {
    final db = await database;
    await db.delete('redacteurs');
  }
}
