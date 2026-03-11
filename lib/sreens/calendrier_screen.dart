import 'package:flutter/material.dart';

class Calendrier extends StatefulWidget {
  const Calendrier({super.key});

  @override
  State<Calendrier> createState() => _CalendrierState();
}

class _CalendrierState extends State<Calendrier> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = screenWidth * 0.35;
    final List<String> jours = [
      "Dimanche",
      "Lundi",
      "Mardi",
      "Mercredi",
      "Jeudi",
      "Vendredi",
      "Samedi",
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
          onPressed: () {
          },

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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
