# Magazine Infos — Gestion des rédacteurs

Application Flutter de gestion locale des rédacteurs du magazine « Magazine Infos », développée dans le cadre de l'Activité n°5 (D-CLIC Francophonie — Développement Mobile, niveau intermédiaire).

## Objectif

Gérer une liste de rédacteurs (ajout, affichage, modification, suppression) avec un stockage local via SQLite (`sqflite`), sans connexion réseau.

## Fonctionnalités

### Obligatoires
- Ajout d'un rédacteur (nom, prénom, email)
- Affichage de la liste des rédacteurs (`ListView.builder`)
- Modification d'un rédacteur via une boîte de dialogue
- Suppression d'un rédacteur avec confirmation
- Chargement automatique des données au démarrage (`initState`)

### Améliorations facultatives
- Validation stricte du format de l'adresse e-mail
- Message de confirmation (SnackBar) après chaque action
- Tri automatique des rédacteurs par nom
- Recherche locale par nom/prénom (icône 🔍 dans l'AppBar)
- Suppression de tous les rédacteurs via le menu latéral (icône ☰)

## Organisation du projet

```
lib/
  main.dart
  modele/
    redacteur.dart
  services/
    database_manager.dart
  views/
    redacteur_interface.dart
test/
  redacteur_model_test.dart
  database_manager_test.dart
  redacteur_interface_test.dart
```

## Captures d'écran

| Liste des rédacteurs | Ajout |
|---|---|
| ![Liste](docs/screenshots/01_liste.png) | ![Ajout](docs/screenshots/02_ajout.png) |

| Modification | Suppression |
|---|---|
| ![Modification](docs/screenshots/03_modification.png) | ![Suppression](docs/screenshots/04_suppression.png) |

| Recherche | Menu / Vider la liste |
|---|---|
| ![Recherche](docs/screenshots/05_recherche.png) | ![Menu](docs/screenshots/06_menu_vider.png) |

## Choix de conception

- Séparation claire modèle / services / vues, conformément aux recommandations du PDF.
- CRUD implémenté avec l'API haut niveau de `sqflite` (`insert`, `update`, `delete`, `query`) plutôt que du SQL brut, pour rester lisible à ce niveau.
- Tests automatisés : modèle (`toMap`/`fromMap`), base de données (CRUD complet via `sqflite_common_ffi`), et interface (ajout, validation, recherche).

## Installation et exécution

```bash
git clone https://github.com/DavFilsDev/magazine-infos.git
cd magazine_infos
flutter pub get
flutter run
```

## Tests

```bash
flutter analyze
flutter test
dart format .
```