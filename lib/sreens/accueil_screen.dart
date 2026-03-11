import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:ti_asistan/service/apiService.dart';
import 'package:ti_asistan/utiltaires/fablocation.dart';
import 'package:ti_asistan/widgets/bottomnavbar.dart';
import 'package:ti_asistan/widgets/eventjour.dart';
import 'package:ti_asistan/widgets/info.dart';
import 'package:ti_asistan/widgets/productivite.dart';
import 'package:ti_asistan/widgets/taches.dart';

class Evenements {
  String nom = "";
  String? projet = "";
  String? calendrier = "";
  DateTime start = DateTime(0);
  DateTime end = DateTime(0);

  Evenements({
    required this.nom,
    required this.projet,
    required this.start,
    required this.end,
  });
}

class AccueilScreen extends StatefulWidget {
  const AccueilScreen({super.key});
  @override
  _AccueilScreenState createState() => _AccueilScreenState();
}

class _AccueilScreenState extends State<AccueilScreen> {
  final service = Apiservice();
  SpeechToText speech = SpeechToText();
  String text = "Appuyez pour parler";

  // 2. Crée une fonction pour changer le texte
  void changerTexte(String nouveauTexte) {
    setState(() {
      text = nouveauTexte;
    });
  }

  List<Evenements> events = List.generate(
    8,
    (index) => Evenements(
      nom: "Epreuve Synthese",
      projet: "Ti Asistan",
      start: DateTime.now(),
      end: DateTime.now().add(Duration(days: 30)),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Info(text: text),
                  SizedBox(height: 10),
                  Productivite(),
                ],
              ),
              SizedBox(width: 10),

              Stack(
                clipBehavior: Clip.none,
                children: [
                  Eventjour(evenements: events.take(4).toList()),

                  if (events.length > 5)
                    Positioned(
                      bottom: -10,
                      right: -5,
                      child: Container(
                        alignment: Alignment.center,
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "+${events.length - 5}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),

          SizedBox(height: 10),
          SizedBox(height: 10),
          Taches(),
        ],
      ),
      
      
    );
  }
}
