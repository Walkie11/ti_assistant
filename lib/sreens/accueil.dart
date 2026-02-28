import 'package:flutter/material.dart';
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

class Accueil extends StatefulWidget {
  const Accueil({super.key});
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
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
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 66, 54, 17),
        elevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(color: Colors.white, width: 8),
        ),
        child: Icon(Icons.mic, color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Column(children: [
      Info(),
      SizedBox(height: 10),
      Productivite()
    ],),
    SizedBox(width: 10),

    Stack(
      clipBehavior: Clip.none,
      children: [
        Eventjour(
          evenements: events.take(4).toList(),
        ),

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
      floatingActionButtonLocation: CustomFabLocation(),
      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.only(bottom: 15, top: 5, right: 10, left: 10),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Bottomnavbar(),
      ),
    );
  }
}
