import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:magazine_infos/services/database_manager.dart';
import 'package:magazine_infos/modele/redacteur.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test('insert puis getAll retourne le rédacteur', () async {
    final db = DatabaseManager();
    final r = Redacteur.sansId(
      nom: 'Test',
      prenom: 'User',
      email: 'test@mail.com',
    );
    await db.insertRedacteur(r);
    final all = await db.getAllRedacteurs();
    expect(all.any((x) => x.email == 'test@mail.com'), isTrue);
  });
}
