import 'package:flutter/material.dart';
import 'package:ti_asistan/Providers/iObjectProvider.dart';
import 'package:ti_asistan/objet/evenement.dart';
import 'package:ti_asistan/service/apiService.dart';

class EvenementProv with ChangeNotifier implements Iobjectprovider<Evenement> {
  @override
  Apiservice api = Apiservice();

  @override
  bool isLoading = false;

  @override
  List<Evenement> objets = [];

  @override
  void charger(List<Evenement> objets) {
    objets.addAll(objets);
  }

  @override
  void initialiser() {}
}
