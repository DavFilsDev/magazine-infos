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

  test('update modifie correctement le rédacteur', () async {
    final db = DatabaseManager();
    final r = Redacteur.sansId(
      nom: 'Avant',
      prenom: 'X',
      email: 'avant@mail.com',
    );
    final id = await db.insertRedacteur(r);
    final updated = Redacteur(
      id: id,
      nom: 'Après',
      prenom: 'X',
      email: 'apres@mail.com',
    );
    await db.updateRedacteur(updated);
    final all = await db.getAllRedacteurs();
    expect(all.any((x) => x.nom == 'Après'), isTrue);
  });

  test('delete supprime le rédacteur', () async {
    final db = DatabaseManager();
    final r = Redacteur.sansId(
      nom: 'ASupprimer',
      prenom: 'X',
      email: 'del@mail.com',
    );
    final id = await db.insertRedacteur(r);
    await db.deleteRedacteur(id);
    final all = await db.getAllRedacteurs();
    expect(all.any((x) => x.id == id), isFalse);
  });

  test('deleteAll vide la table', () async {
    final db = DatabaseManager();
    await db.insertRedacteur(
      Redacteur.sansId(nom: 'A', prenom: 'B', email: 'a@mail.com'),
    );
    await db.deleteAllRedacteurs();
    final all = await db.getAllRedacteurs();
    expect(all, isEmpty);
  });
}
