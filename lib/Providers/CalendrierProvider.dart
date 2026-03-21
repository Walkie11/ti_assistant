import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class Evenement {
  final String nom;
  final String description;
  final DateTime debut;
  final DateTime fin;
  final Color couleur = Colors.lightBlueAccent;
  final bool estARappeler = false;

  Evenement(this.nom, this.description, this.debut, this.fin);
  factory Evenement.fromJson(Map<String, dynamic> json) {
    return Evenement(
      json['nom'],
      json['description'],
      DateTime.parse(json['debut']),
      DateTime.parse(json['fin']),
    );
  }
}

class Calendrier {
  final String nom;
  late bool estActive;
  final List<Evenement> evenements;
  final Color couleur;

  Calendrier(this.nom, this.estActive, this.evenements, this.couleur);
  factory Calendrier.fromJson(Map<String, dynamic> json) {
    return Calendrier(
      json['nom'],
      json['estActive'],
      json['evenements'] != null
          ? (json['evenements'] as List)
                .map((e) => Evenement.fromJson(e))
                .toList()
          : [],
      json['couleur'] != null
          ? Color(json['couleur'].replaceFirst('#', '0xff'))
          : Colors.amber,
    );
  }
}

class Calendrierprovider with ChangeNotifier {
  final List<Calendrier> _calendriers = [
    // 1. Calendrier Travail (Bleu)
    Calendrier("Travail", true, [
      Evenement(
        "Réunion d'équipe",
        "Point hebdomadaire sur le projet Ti Asistan",
        DateTime.now().add(const Duration(hours: 2)),
        DateTime.now().add(const Duration(hours: 3)),
      ),
      Evenement(
        "Développement Flutter",
        "Coder l'animation Heartbeat du micro",
        DateTime.now().add(const Duration(days: 1, hours: 9)),
        DateTime.now().add(const Duration(days: 1, hours: 12)),
      ),
    ], Colors.blue),

    // 2. Calendrier Personnel (Vert)
    Calendrier("Personnel", true, [
      Evenement(
        "Salle de sport",
        "Séance de cardio et musculation",
        DateTime.now().add(const Duration(hours: 18)),
        DateTime.now().add(const Duration(hours: 19, minutes: 30)),
      ),
    ], Colors.green),

    // 3. Calendrier Anniversaires (Orange - Désactivé par défaut)
    Calendrier("Anniversaires", false, [
      Evenement(
        "Anniversaire de Marie",
        "Ne pas oublier le cadeau !",
        DateTime(2026, 05, 15),
        DateTime(2026, 05, 15),
      ),
    ], Colors.orange),
  ];
  final List<Evenement> _evenements = [];
  List<Calendrier> get calendriers => _calendriers;
  List<Evenement> get evenements => _evenements;
  bool isLoading = false;
 
  void chargerCalendriers(List<Calendrier> cals) {
    isLoading = true;
    for (Calendrier c in cals) {
      _calendriers.add(c);
      if (c.estActive) {
        _evenements.addAll(evenements);
      }
    }
    isLoading = false;
    notifyListeners();
  }

  void filtrerCalendrier(String nom) {
    final cal = _calendriers.firstWhere((c) => c.nom == nom);
    cal.estActive = !cal.estActive;
    if (cal.estActive) {
      _evenements.addAll(cal.evenements);
    }
  }
}
