class Redacteur {
  int? id;
  String nom;
  String prenom;
  String email;

  Redacteur({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
  });

  Redacteur.sansId({
    required this.nom,
    required this.prenom,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'nom': nom, 'prenom': prenom, 'email': email};
  }
}
