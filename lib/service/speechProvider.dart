import 'package:flutter/widgets.dart';

class Speechprovider with ChangeNotifier {
  String _text = "";
  String get text => _text;
  void changerTexte(String nouveauTexte) {
    _text = nouveauTexte;
    notifyListeners();
  }
}
