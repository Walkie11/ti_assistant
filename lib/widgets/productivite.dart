import 'package:flutter/material.dart';

class Tache {
  String nom = "";
  String statut = "";
  DateTime? completedAt = DateTime(0);
  Tache({required this.nom, required this.statut, required this.completedAt});
}

class Productivite extends StatefulWidget {
  Productivite({super.key});
  final List<Tache> taches = List.empty();
  @override
  State<StatefulWidget> createState() => _ProductiviteState();
}

class _ProductiviteState extends State<Productivite> {
  List<Tache> taches = List.generate(
    7,
    (index) => Tache(
      nom: "Preparer itération 2",
      statut: "À faire",
      completedAt: null,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.40,
      alignment: Alignment.center,
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.24 ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 236, 227, 209),
        borderRadius: BorderRadius.circular(15),
      ),
      child: GridView.builder(
        reverse: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 30,
        ),
        itemCount: taches.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(1),
            color: taches[index].statut.toLowerCase() == "complété"
                ? const Color.fromARGB(255, 19, 151, 15)
                : taches[index].statut.toLowerCase() == "en cours"
                ? const Color.fromARGB(255, 255, 85, 7)
                : Colors.white,
          );
        },
      ),
    );
  }
}
