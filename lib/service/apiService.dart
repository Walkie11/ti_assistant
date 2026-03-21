import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:flutter/material.dart';
import 'package:ti_asistan/Providers/CalendrierProvider.dart';
import 'package:ti_asistan/variables.dart';
import 'package:http/http.dart' as http;

class Apiservice {
  late HubConnection hub;

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
    final calendrierProvider = Provider.of<Calendrierprovider>(context);
    hub.on("Calendrier", (reponse) {
     if (reponse != null && reponse.isNotEmpty) {
        final Map<String, dynamic> reponseComplete =reponse[0] as Map<String, dynamic>;

        // 2. On accède à la propriété 'data' (qui contient tes calendriers)
        final List<dynamic>? dataBrute = reponseComplete['data'];

        // Ensuite tu fais ton mapping comme prévu :
        final cals = dataBrute!.map((item) => Calendrier.fromJson(item))
            .toList();
        calendrierProvider.chargerCalendriers(cals);
      }
      navigatorKey.currentState!.pushReplacementNamed('/calendrier');
      showPopup("Vous avez des événements à venir !");
    });
    hub.on("RecevoirEvenements", (reponse) {
      print("Événements reçus : $reponse");
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

      final reponse = await http.post(url);
      if (reponse.statusCode != 200) {}
    } catch (e) {
      print("Erreur: " + e.toString());
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
