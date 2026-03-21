import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ti_asistan/Providers/CalendrierProvider.dart';
import 'package:ti_asistan/widgets/evenement.dart';
import 'package:ti_asistan/widgets/micro.dart';

class CalendrierScreen extends StatefulWidget {
  const CalendrierScreen({super.key});

  @override
  State<CalendrierScreen> createState() => _CalendrierScreenState();
}

class _CalendrierScreenState extends State<CalendrierScreen> {
  // 1. Déclare tes variables ICI (au niveau de la classe)
  late List<DateTime> datesJrs;
  final List<String> jours = [];
  late String mois;

  @override
  void initState() {
    super.initState();
    // 2. Initialise tes données une seule fois
    datesJrs = List.generate(
      7,
      (index) => DateTime.now().add(Duration(days: index)),
    );

    for (int i = 0; i < 7; i++) {
      String jourDebut = DateFormat('d MMM', 'fr_FR').format(datesJrs.first);
      jourDebut = jourDebut[0].toUpperCase() + jourDebut.substring(1);

      String moisFin = DateFormat('d MMM', 'fr_FR').format(datesJrs.last);
      moisFin = moisFin[0].toUpperCase() + moisFin.substring(1);

      if (jourDebut != moisFin) {
        mois = "$jourDebut - $moisFin";
      } else {
        mois = jourDebut;
      }
      String formatte = DateFormat('EEEE d', 'fr_FR').format(datesJrs[i]);

      jours.add(formatte[0].toUpperCase() + formatte.substring(1));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provCalendrier = Provider.of<Calendrierprovider>(context);
    print(provCalendrier.calendriers.length);
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double itemWidth = screenWidth * 0.35;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          PopupMenuButton<Calendrier>(
            icon: const Icon(Icons.filter_list),
            onSelected: (Calendrier cal) {
              provCalendrier.filtrerCalendrier(cal.nom);
            },
            itemBuilder: (BuildContext context) {
              return provCalendrier.calendriers.map((cal) {
                return CheckedPopupMenuItem<Calendrier>(
                  value: cal,
                  checked: cal.estActive,
                  child: Text(cal.nom),
                );
              }).toList();
            },
          ),
        ],
        title: Center(
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back_ios_new_rounded),
              ),
              Text(mois),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ],
          ),
        ),
        elevation: 0,
      ),
      floatingActionButton: Micro(),

      body: Row(
        children: [
          Container(
            width: screenWidth * 0.1,
            child: Column(
              children: [
                SizedBox(height: screenHeight *0.06),
                Container(
                  width: screenWidth * 0.1,
                  height: screenHeight * 0.88,
                  color: const Color.fromARGB(133, 44, 44, 44),
                ),
              ],
            ),
          ),
          SizedBox(width: 5),

          Expanded(
            child: Stack(
              children: [
                ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 2),
                  itemCount: 7,
                  itemBuilder: (context, dayIndex) {
                    final DateTime jourDeLaColonne = datesJrs[dayIndex];
                    final double hauteurTotaleZone =
                        MediaQuery.of(context).size.height * 0.883;
                    final double hauteurHeure = hauteurTotaleZone / 24;

                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: itemWidth,
                          height: 50,
                          color: const Color.fromARGB(255, 43, 43, 40),
                          child: Text(
                            jours[dayIndex],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 10),

                        Container(
                          width: itemWidth,
                          height: hauteurTotaleZone,
                          color: const Color.fromARGB(255, 43, 43, 40),
                          child: Stack(
                            children: provCalendrier.evenements
                                .where((event) {
                                  return event.debut.day ==jourDeLaColonne.day &&
                                      event.debut.month ==jourDeLaColonne.month &&
                                      event.debut.year == jourDeLaColonne.year;
                                })
                                .map((event) {
                                  final double topPosition =
                                      (event.debut.hour +
                                          (event.debut.minute / 60)) *
                                      hauteurHeure;

                                  return Positioned(
                                    top: topPosition,
                                    left: 0,
                                    right: 0,
                                    child: EvenementWidget(evenement: event),
                                  );
                                })
                                .toList(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Positioned(
                  top:
                      (MediaQuery.of(context).size.height * 0.883) /
                          24 *
                          (DateTime.now().hour + DateTime.now().minute / 60) +
                      55, // Sa position verticale
                  left: 0, // Elle commence au bord gauche de la Stack
                  right: 0, // Elle s'étire jusqu'au bord droit de la Stack
                  child: Container(
                    height: 2, // L'épaisseur de ta ligne
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
