import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:flutter/material.dart';
import 'package:ti_asistan/Providers/CalendrierProvider.dart';
import 'package:ti_asistan/Providers/TacheProvider.dart';
import 'package:ti_asistan/objet/calendrier.dart';
import 'package:ti_asistan/objet/evenement.dart';
import 'package:ti_asistan/sreens/taches_screen.dart';
import 'package:ti_asistan/variables.dart';
import 'package:http/http.dart' as http;
import 'package:ti_asistan/widgets/tacheWidget.dart';

class Apiservice {
  late HubConnection hub;
  var secured = FlutterSecureStorage();

  final String baseUrl =
      "https://uncharmable-excursively-colette.ngrok-free.dev";
  void showPopup(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
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
    ScaffoldMessenger.of(navigatorKey.currentContext!).removeCurrentSnackBar();
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
  }

  void initSignalR(BuildContext context) async {
    hub = HubConnectionBuilder()
        .withUrl(
          "$baseUrl/assistantHub",
          // options: HttpConnectionOptions(
          //   accessTokenFactory: () async{
          //      var token = await secured.read(key: "token");
          //     return token?? "";},
          // )
        )
        .build();
    final calendrierProvider = Provider.of<Calendrierprovider>(
      context,
      listen: false,
    );
    final tacheProvider = Provider.of<Tacheprovider>(context, listen: false);
    hub.on("Calendrier", (reponse) {
      if (reponse != null && reponse.isNotEmpty) {
        final Map<String, dynamic> reponseComplete =
            reponse[0] as Map<String, dynamic>;
        final List<dynamic>? dataBrute = reponseComplete['data'];
        final cals = dataBrute!
            .map((item) => Calendrier.fromJson(item))
            .toList();
        if (cals.length == 1) {
          navigatorKey.currentState!.pushReplacementNamed(
            '/calendrier',
            arguments: cals,
          );
          showPopup("Calendriers");
        } else {
          calendrierProvider.charger(cals);
          navigatorKey.currentState!.pushReplacementNamed('/calendrier');
          showPopup("Calendriers charges");
        }
      }
    });

    hub.on("RecevoirProjet", (reponse) {
      print("Projets reçus : $reponse");
    });
    hub.on("RecevoirTache", (reponse) {
      if (reponse != null && reponse.isNotEmpty) {
        final Map<String, dynamic> reponseComplete =
            reponse[0] as Map<String, dynamic>;
        final List<dynamic>? dataBrute = reponseComplete['data'];
        final taches = dataBrute!.map((item) => Tache.fromJson(item)).toList();
        if (taches.length == 1) {
          final laSeuleTache = taches[0];
          navigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (context) => Tachewidget(tache: laSeuleTache),
            ),
          );
          toast("Récupération réussie");
        } else if (taches.length > 1) {
          tacheProvider.charger(taches);
          navigatorKey.currentState!.pushReplacementNamed('/tache');
          toast("Voici vos tâches");
        } else {
          toast(reponseComplete['datail']);
        }
        print("Tâches reçues : $reponse");
      }
    });
    hub.on("AssistantNotification", (reponse) {
      toast("Notification du serveur : $reponse");
    });
    hub.onclose(({error}) => toast("Connexion perdue : $error"));
  }

  Future<void> envoyerIntention(String text) async {
    try {
      final url = Uri.parse("$baseUrl/api/Assistant");
      var token = await secured.read(key: 'token');
      final reponse = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({"input": text}),
      );
      if (reponse.statusCode != 200) {
        toast("Envoyé");
      }
    } catch (e) {
      toast("Erreur:  ${e.toString()}");
    }
  }

  Future<http.Response?> Connecter(String userName, String password) async {
    try {
      final url = Uri.parse("$baseUrl/login");

      final reponse = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"Nom": userName, "Password": password}),
      );
      showSimpleNotification(Text("Connecté"));
      return reponse;
    } catch (e) {
      toast("Erreur: ${e.toString()}");
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
      toast("Connexion SignalR établie !");
    } catch (e) {
      print("Erreur de connexion : $e");
    }
  }

  Future<List<Calendrier>> recevoirCalendriers() async {
    if (hub.state == HubConnectionState.Connected) {
      await hub.invoke("Calendriers");
      return [];
    } else {
      return [];
    }
  }

  Future<void> recevoirEvenements() async {
    if (hub.state == HubConnectionState.Connected) {
      await hub.invoke("sendEvenements");
    } else {
      // Demander de se connecter
    }
  }

  Future<List<Tache>> recevoirTaches() async {
    if (hub.state == HubConnectionState.Connected) {
      await hub.invoke("sendTaches");
      return [];
    } else {
      return [];
    }
  }

  Future<void> RecevoirProjets() async {
    if (hub.state == HubConnectionState.Connected) {
      await hub.invoke("sendProjets");
    } else {}
  }
}
