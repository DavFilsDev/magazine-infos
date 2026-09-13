import 'package:flutter/material.dart';

import '../modele/redacteur.dart';
import '../services/database_manager.dart';

class RedacteurInterface extends StatefulWidget {
  const RedacteurInterface({super.key});

  @override
  State<RedacteurInterface> createState() => _RedacteurInterfaceState();
}

class _RedacteurInterfaceState extends State<RedacteurInterface> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final DatabaseManager _dbManager = DatabaseManager();
  List<Redacteur> _redacteurs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestion des rédacteurs')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _nomController,
              decoration: const InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: _prenomController,
              decoration: const InputDecoration(labelText: 'Prénom'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _ajouterRedacteur,
              icon: const Icon(Icons.add),
              label: const Text('Ajouter un Rédacteur'),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _redacteurs.length,
                itemBuilder: (context, index) {
                  final r = _redacteurs[index];
                  return Card(
                    child: ListTile(
                      title: Text('${r.nom} ${r.prenom}'),
                      subtitle: Text(r.email),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _modifierRedacteur(r),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _chargerRedacteurs();
  }

  Future<void> _chargerRedacteurs() async {
    final data = await _dbManager.getAllRedacteurs();
    setState(() {
      _redacteurs = data;
    });
  }

  Future<void> _ajouterRedacteur() async {
    if (_nomController.text.isEmpty ||
        _prenomController.text.isEmpty ||
        _emailController.text.isEmpty) {
      return;
    }
    final r = Redacteur.sansId(
      nom: _nomController.text,
      prenom: _prenomController.text,
      email: _emailController.text,
    );
    await _dbManager.insertRedacteur(r);
    _nomController.clear();
    _prenomController.clear();
    _emailController.clear();
    await _chargerRedacteurs();
  }

  Future<void> _modifierRedacteur(Redacteur r) async {
    final nomCtrl = TextEditingController(text: r.nom);
    final prenomCtrl = TextEditingController(text: r.prenom);
    final emailCtrl = TextEditingController(text: r.email);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Modifier Rédacteur'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nomCtrl,
              decoration: const InputDecoration(labelText: 'Nouveau Nom'),
            ),
            TextField(
              controller: prenomCtrl,
              decoration: const InputDecoration(labelText: 'Nouveau Prénom'),
            ),
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: 'Nouvel Email'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () async {
              final updated = Redacteur(
                id: r.id,
                nom: nomCtrl.text,
                prenom: prenomCtrl.text,
                email: emailCtrl.text,
              );
              await _dbManager.updateRedacteur(updated);
              await _chargerRedacteurs();
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }
}
