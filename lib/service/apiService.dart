import 'package:signalr_netcore/signalr_client.dart';
import 'package:http/http.dart' as http;

class Apiservice {
  late HubConnection hub;

  final String baseUrl = "https://tiassistant.api";

  void initSignalR() {
    hub = HubConnectionBuilder().withUrl(baseUrl).build();
    hub.on("RecevoirCalendrier", (reponse) {});
    hub.on("RecevoirEvenements", (reponse) {});
    hub.on("RecevoirProjet", (reponse) {});
    hub.on("RecevoirTache", (reponse) {});
    hub.onclose(({error}) => print("Connexion perdue : $error"));
  }

  Future<void> envoyerIntention(String text) async {
    try {
      final url = Uri.parse(baseUrl);

      final reponse = await http.post(url);
      if(reponse.statusCode!=200){

      }
    } catch (e) {
      print("Erreur: " + e.toString());
    }
  }

  Future<void> startConnection() async {
    try {
      await hub.start();
      // print("Connexion SignalR établie !");
    } catch (e) {
      // print("Erreur de connexion : $e");
    }
  }

  Future<void> recevoirCalendriers() async {
    if (hub.state == HubConnectionState.Connected) {
      await hub.invoke("sendCalendriers");
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
