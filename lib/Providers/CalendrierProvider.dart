import 'package:flutter/material.dart';
import 'package:ti_asistan/objet/calendrier.dart';
import 'package:ti_asistan/objet/evenement.dart';

class Calendrierprovider with ChangeNotifier {
  final List<Calendrier> _calendriers = [];
  final List<Evenement> _evenements = [];
  List<Calendrier> get calendriers => _calendriers;
  List<Evenement> get evenements => _evenements;
  bool isLoading = false;

  void chargerCalendriers(List<Calendrier> cals) {
    isLoading = true;
    for (Calendrier c in cals) {
      _calendriers.add(c);
      if (c.estActive) {
        for (Evenement e in evenements) {
          e.couleurCalendrier = c.couleur;
        }
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
