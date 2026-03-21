import 'dart:ui';

import 'package:ti_asistan/objet/evenement.dart';

class Calendrier {
  final String nom;
  final List<Evenement> evenements;
  final Color couleur;
  bool estActive;

  Calendrier({
    required this.nom,
    required this.estActive,
    required this.evenements,
    required this.couleur,
  });
  factory Calendrier.fromJson(Map<String, dynamic> json) {
    return Calendrier(
      nom: json['nom'],
      estActive: json['estActive'],
      evenements: json['evenements'] != null
          ? (json['evenements'] as List)
                .map((e) => Evenement.fromJson(e))
                .toList()
          : [],
      couleur: Color(json['couleur'].replaceFirst('#', '0xff')),
    );
  }
}
