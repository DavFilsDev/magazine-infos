import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:magazine_infos/main.dart';
import 'package:magazine_infos/services/database_manager.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    await DatabaseManager().deleteAllRedacteurs();
  });

  testWidgets('ajouter un rédacteur valide l\'affiche dans la liste', (
    tester,
  ) async {
    await tester.pumpWidget(const MonApplication());
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextField, 'Nom'), 'Dupont');
    await tester.enterText(find.widgetWithText(TextField, 'Prénom'), 'Jean');
    await tester.enterText(
      find.widgetWithText(TextField, 'Email'),
      'jean@mail.com',
    );
    await tester.tap(find.text('Ajouter un Rédacteur'));
    await tester.pumpAndSettle();

    expect(find.text('Dupont Jean'), findsOneWidget);
  });

  testWidgets('email invalide affiche un message et n\'ajoute rien', (
    tester,
  ) async {
    await tester.pumpWidget(const MonApplication());
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextField, 'Nom'), 'Test');
    await tester.enterText(find.widgetWithText(TextField, 'Prénom'), 'X');
    await tester.enterText(
      find.widgetWithText(TextField, 'Email'),
      'pasunemail',
    );
    await tester.tap(find.text('Ajouter un Rédacteur'));
    await tester.pumpAndSettle();

    expect(find.text('Adresse e-mail invalide'), findsOneWidget);
    expect(find.text('Test X'), findsNothing);
  });

  testWidgets('la recherche filtre la liste', (tester) async {
    await DatabaseManager()
        .insertRedacteur(
          (await DatabaseManager().getAllRedacteurs()).isEmpty
              ? throw Exception('setup only')
              : throw Exception('unused'),
        )
        .catchError((_) {});

    await tester.pumpWidget(const MonApplication());
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextField, 'Nom'), 'Alpha');
    await tester.enterText(find.widgetWithText(TextField, 'Prénom'), 'A');
    await tester.enterText(
      find.widgetWithText(TextField, 'Email'),
      'alpha@mail.com',
    );
    await tester.tap(find.text('Ajouter un Rédacteur'));
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextField, 'Prénom'), 'B');
    await tester.enterText(find.widgetWithText(TextField, 'Nom'), 'Beta');
    await tester.enterText(
      find.widgetWithText(TextField, 'Email'),
      'beta@mail.com',
    );
    await tester.tap(find.text('Ajouter un Rédacteur'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, 'Alpha');
    await tester.pumpAndSettle();

    expect(find.text('Alpha A'), findsOneWidget);
    expect(find.text('Beta B'), findsNothing);
  });
}
