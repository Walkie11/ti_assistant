import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ti_asistan/widgets/evenement.dart';

class CalendrierI {
  final String id;
  final String nom;
  late bool estActive;
  late List<Evenement> evenements;
  CalendrierI(this.id, this.nom, this.estActive);
}

class Calendrier extends StatefulWidget {
  const Calendrier({super.key});

  @override
  State<Calendrier> createState() => _CalendrierState();
}

class _CalendrierState extends State<Calendrier> {
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
    // 3. Le build ne s'occupe QUE du dessin
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = screenWidth * 0.35;
    final List<CalendrierI> mesCalendriers = [
      CalendrierI('1', 'Professionnel', true),
      CalendrierI('2', 'Personnel', true),
      CalendrierI('3', 'Loisirs', true),
    ];
    final List<Evenement> evenements = [
      Evenement(
        "Concert",
        "LoremIpsum",
        DateTime.now().add(const Duration(days: 0)),
        DateTime.now().add(const Duration(days: 0, hours: 5)),
      ),
      Evenement(
        "Concert",
        "LoremIpsum",
        DateTime.now().add(const Duration(days: 1, hours: 18)),
        DateTime.now().add(const Duration(days: 2)),
      ),
      Evenement(
        "Concert",
        "LoremIpsum",
        DateTime.now().add(const Duration(days: 1)),
        DateTime.now().add(const Duration(days: 1, hours: 5)),
      ),
      Evenement(
        "Concert",
        "LoremIpsum",
        DateTime.now().add(const Duration(days: 1)),
        DateTime.now().add(const Duration(days: 1, hours: 5)),
      ),
      Evenement(
        "Concert",
        "LoremIpsum",
        DateTime.now().add(const Duration(days: 1)),
        DateTime.now().add(const Duration(days: 1, hours: 5)),
      ),
    ];

    // Le calendrier actuellement coché
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          PopupMenuButton<CalendrierI>(
            icon: const Icon(Icons.filter_list), // Icône du menu
            onSelected: (CalendrierI cal) {
              cal.estActive = !cal.estActive;
            },
            itemBuilder: (BuildContext context) {
              // On transforme la liste d'objets en liste de widgets de menu
              return mesCalendriers.map((CalendrierI cal) {
                return CheckedPopupMenuItem<CalendrierI>(
                  value: cal,
                  checked: cal.estActive, // Vérification par ID
                  child: Text(cal.nom),
                );
              }).toList(); // Très important de convertir l'Iterable en List
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
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {},

        backgroundColor: const Color.fromARGB(255, 163, 75, 16),
        elevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(color: Colors.white, width: 2),
        ),
        child: Icon(Icons.mic, color: Colors.white),
      ),
      drawerDragStartBehavior: DragStartBehavior.start,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets
              .zero, // Important pour que le header remplisse tout le haut
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Text(
                'Menu Principal',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil'),
              onTap: () {
                Navigator.pop(context); // Ferme le drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Calendrier'),
              onTap: () {
                Navigator.pop(context); // Ferme le drawer
                Navigator.pushNamed(context, '/calendrier');
              },
            ),
            const Divider(), // Une ligne de séparation
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Paramètres'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.1,
            child: Column(
              children: [
                SizedBox(height: 60),
                Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.height * 0.884,
                  color: const Color.fromARGB(134, 85, 9, 9),
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
                            children: evenements
                                .where((event) {
                                  return event.debut.day ==
                                          jourDeLaColonne.day &&
                                      event.debut.month ==
                                          jourDeLaColonne.month &&
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
