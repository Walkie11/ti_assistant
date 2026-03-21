import 'dart:ui';

class Evenement {
  String nom;
  String nomCalendrier;
  String description;
  DateTime debut;
  DateTime fin;
  Color couleur;
  Color couleurCalendrier = const Color.fromARGB(155, 187, 148, 97);
  bool estARappeler = false;

  Evenement({
    required this.nom,
    required this.nomCalendrier,
    required this.description,
    required this.debut,
    required this.fin,
    this.couleur = const Color.fromARGB(0, 111, 121, 126),
    this.couleurCalendrier = const Color.fromARGB(255, 74, 173, 223),
  });
  factory Evenement.fromJson(Map<String, dynamic> json) {
    return Evenement(
      nom: json['nom'],
      nomCalendrier: json['description'],
      description: json['nomCalendrier'],
      debut: DateTime.parse(json['debut']),
      fin: DateTime.parse(json['fin']),
    );
  }
}
