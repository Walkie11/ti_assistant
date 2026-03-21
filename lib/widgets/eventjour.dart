import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ti_asistan/Providers/CalendrierProvider.dart';
import 'package:ti_asistan/objet/evenement.dart';
import 'package:ti_asistan/sreens/accueil_screen.dart';
import 'package:ti_asistan/widgets/event.dart';
import 'package:ti_asistan/widgets/liveevent.dart';

class Eventjour extends StatefulWidget {
  Eventjour({super.key});

  @override
  State<Eventjour> createState() => _EventjourState();
}

class _EventjourState extends State<Eventjour> {
  @override
  Widget build(BuildContext context) {
  var prov = Provider.of<Calendrierprovider>(context);
  final maintenant = DateTime.now();

    List<Evenement> evenements = prov.evenements.where((event) {
      return event.debut.day == maintenant.day &&
          event.debut.month == maintenant.month &&
          event.debut.year == maintenant.year;
    }).toList();
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.5,
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 65, 57, 54),
        borderRadius: BorderRadius.circular(15),
      ),
      child: evenements.isEmpty
          ? Column(
              children: [
                LiveEvent(
                  titre: "Disponible",
                  projet: "Le reste de la journée",
                  calendrier: "",
                  end: null,
                  start: null,
                ),
              ],
            )
          : ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: evenements.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      LiveEvent(
                        projet:evenements[index].nomCalendrier,
                        titre:evenements[index].nom,
                        calendrier:evenements[index].nomCalendrier,
                        start:evenements[index].debut,
                        end:evenements[index].fin,
                      ),
                      SizedBox(height: 2),
                    ],
                  );
                }

                return Column(
                  children: [
                    Event(
                      titre: evenements[index].nom,
                      start: evenements[index].debut,
                      end: evenements[index].fin,
                    ),
                    SizedBox(height: 2),
                  ],
                );
              },
            ),
    );
  }
}
