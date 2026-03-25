import 'package:flutter/material.dart';
import 'package:ti_asistan/Providers/evenementProv.dart';
import 'package:ti_asistan/Providers/iObjectProvider.dart';
import 'package:ti_asistan/objet/calendrier.dart';
import 'package:ti_asistan/objet/evenement.dart';
import 'package:ti_asistan/service/apiService.dart';

class Calendrierprovider
    with ChangeNotifier
    implements Iobjectprovider<Calendrier> {
        List<Calendrier> get calendriers => objets;
  @override
  bool isLoading = false;

  @override
  Apiservice api = Apiservice();

  @override
  List<Calendrier> objets = [];
  var evenementProv = EvenementProv();

  @override
  void charger(List<Calendrier> objets) {
    isLoading = true;
    for (Calendrier c in objets) {
      objets.add(c);
      if (c.estActive) {
        for (Evenement e in c.evenements) {
          e.couleurCalendrier = c.couleur;
        }
        evenementProv.objets.addAll(c.evenements);
      }
    }
    isLoading = false;
    notifyListeners();
  }

  @override
  void initialiser() async {
    charger(await api.recevoirCalendriers());
  }



  void filtrerCalendrier(String nom) {
    final cal = objets.firstWhere((c) => c.nom == nom);
    cal.estActive = !cal.estActive;
    if (cal.estActive) {
      evenementProv.objets.addAll(cal.evenements);
    }
  }
}
