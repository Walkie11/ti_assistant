import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ti_asistan/service/apiService.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Authprovider with ChangeNotifier {
  bool isConnected = false;
  bool isLoading = true;
  bool estInscrit = false;
  bool get Connected => isConnected;
  final prefs = FlutterSecureStorage();
  var api = Apiservice();
  Authprovider() {
    initState();
  }
  void initState() async {
    isConnected = false;
    isLoading = true;
    bool containsKey = await prefs.containsKey(key: 'token');
    print('Token exists: $containsKey');
    if (containsKey) {
      isConnected = true;
    } else {
      isConnected = false;
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> Connecter(String userName, String password) async {
    this.isLoading = true;
    var reponse = await api.Connecter(userName, password);
    if (reponse != null) {
      if (reponse.statusCode == 200) {
        final data = jsonDecode(reponse.body);
        await prefs.write(key: 'token', value: data['token']);
        this.isConnected = true;
        notifyListeners();
      }
    }
  }

  Future<void> Inscrire(String userName, String mail, String password) async {
    this.isLoading = true;
    var reponse = await api.Inscrire(userName, mail, password);
    if (reponse != null) {
      if (reponse.statusCode == 200) {
        
        this.estInscrit = true;
        notifyListeners();
      }
    }
  }
}
