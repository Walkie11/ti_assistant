import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:flutter/material.dart';
import 'package:ti_asistan/Providers/CalendrierProvider.dart';
import 'package:ti_asistan/objet/calendrier.dart';
import 'package:ti_asistan/variables.dart';
import 'package:http/http.dart' as http;

class Apiservice {
  late HubConnection hub;
  var secured = FlutterSecureStorage();

  final String baseUrl =
      "https://uncharmable-excursively-colette.ngrok-free.dev/assistantHub";
  void showPopup(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating, // Flotte au-dessus du contenu
      margin: EdgeInsets.only(
        top: 10,
        left: 50,
        right: 50,
      ), // Pour le mettre en haut
      action: SnackBarAction(
        label: 'Voir',
        onPressed: () =>
            navigatorKey.currentState?.pushReplacementNamed('/calendrier'),
      ),
    );

    // On utilise le context global de la clé de navigation
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
  }

  void initSignalR(BuildContext context) {
    hub = HubConnectionBuilder().withUrl(baseUrl).build();
    final calendrierProvider = Provider.of<Calendrierprovider>(
      context,
      listen: false,
    );
    hub.on("Calendrier", (reponse) {
      if (reponse != null && reponse.isNotEmpty) {
        final Map<String, dynamic> reponseComplete =
            reponse[0] as Map<String, dynamic>;
        final List<dynamic>? dataBrute = reponseComplete['data'];
        final cals = dataBrute!
            .map((item) => Calendrier.fromJson(item))
            .toList();
        calendrierProvider.chargerCalendriers(cals);
      }
      navigatorKey.currentState!.pushReplacementNamed('/calendrier');
      showPopup("Vous avez des événements à venir !");
    });

    hub.on("RecevoirProjet", (reponse) {
      print("Projets reçus : $reponse");
    });
    hub.on("RecevoirTache", (reponse) {
      print("Tâches reçues : $reponse");
    });
    hub.on("AssistantNotification", (reponse) {
      print("Notification du serveur : $reponse");
    });
    hub.onclose(({error}) => print("Connexion perdue : $error"));
  }

  Future<void> envoyerIntention(String text) async {
    try {
      final url = Uri.parse(baseUrl);
      var token = await secured.read(key: 'token');
      final reponse = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "token": "${token}",
        },
      );
      if (reponse.statusCode != 200) {}
    } catch (e) {
      print("Erreur: " + e.toString());
    }
  }

  Future<http.Response?> Connecter(String userName, String password) async {
    try {
      final url = Uri.parse(baseUrl);

      final reponse = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        }, // Often required for jsonEncode
        body: jsonEncode({"Nom": userName, "Password": password}),
      );

      return reponse;
    } catch (e) {
      print("Erreur: " + e.toString());
      return null;
    }
  }

  Future<http.Response?> Inscrire(
    String userName,
    String email,
    String password,
  ) async {
    try {
      final url = Uri.parse(baseUrl);

      final reponse = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "nom": userName,
          "email": email,
          "password": password,
        }),
      );

      return reponse;
    } catch (e) {
      print("Erreur: " + e.toString());
      return null;
    }
  }

  Future<void> startConnection() async {
    try {
      await hub.start();
      print("Connexion SignalR établie !");
    } catch (e) {
      print("Erreur de connexion : $e");
    }
  }

  Future<void> recevoirCalendriers() async {
    if (hub.state == HubConnectionState.Connected) {
      await hub.invoke("Calendriers");
    } else {
      // Demander de se connecter
    }
  }

  Future<void> recevoirEvenements() async {
    if (hub.state == HubConnectionState.Connected) {
      await hub.invoke("sendCalendriers");
    } else {
      // Demander de se connecter
    }
  }

  Future<void> recevoirTaches() async {
    if (hub.state == HubConnectionState.Connected) {
      await hub.invoke("sendCalendriers");
    } else {
      // Demander de se connecter
    }
  }

  Future<void> RecevoirProjets() async {
    if (hub.state == HubConnectionState.Connected) {
      await hub.invoke("sendCalendriers");
    } else {
      // Demander de se connecter
    }
  }
}
