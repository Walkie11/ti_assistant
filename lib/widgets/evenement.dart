import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ti_asistan/objet/evenement.dart'; 

class EvenementWidget extends StatelessWidget {
  const EvenementWidget({super.key, required this.evenement});
  final Evenement evenement;

  @override
  Widget build(BuildContext context) {
    final double dureeEnHeures = evenement.fin.difference(evenement.debut).inMinutes / 60.0;
    final double hauteurHeure = (MediaQuery.of(context).size.height * 0.83 - 48) / 24;
    final double hauteurTotale = hauteurHeure * dureeEnHeures;

    final String debutFormate = DateFormat('HH:mm').format(evenement.debut);
    final String finFormate = DateFormat('HH:mm').format(evenement.fin);

    return Container(
      height: hauteurTotale,
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 78, 78, 70), //Couleur evenement
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Container(
            height: hauteurTotale,
            width: 4,
            decoration: BoxDecoration(
              color: evenement.couleurCalendrier,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded( 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  evenement.nom,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  "$debutFormate - $finFormate",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
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