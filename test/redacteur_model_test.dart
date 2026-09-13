import 'package:flutter_test/flutter_test.dart';
import 'package:magazine_infos/modele/redacteur.dart';

void main() {
  test('toMap retourne les bonnes clés', () {
    final r = Redacteur(
      id: 1,
      nom: 'Dupont',
      prenom: 'Jean',
      email: 'jean@mail.com',
    );
    final map = r.toMap();
    expect(map['id'], 1);
    expect(map['nom'], 'Dupont');
    expect(map['email'], 'jean@mail.com');
  });

  test('fromMap reconstruit un objet correct', () {
    final map = {
      'id': 2,
      'nom': 'Martin',
      'prenom': 'Alice',
      'email': 'alice@mail.com',
    };
    final r = Redacteur.fromMap(map);
    expect(r.id, 2);
    expect(r.nom, 'Martin');
  });
}
