import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
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
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.center,

                          width: itemWidth,
                          height: 50,
                          color: const Color.fromARGB(255, 43, 43, 40),
                          child: Text(
                            style: TextStyle(color: Colors.white),
                            jours[index],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: itemWidth,
                          height: MediaQuery.of(context).size.height * 0.884,
                          color: const Color.fromARGB(255, 43, 43, 40),
                        ),
                      ],
                    );
                  },
                ),
                Positioned(
                  top: 420, // Sa position verticale
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
