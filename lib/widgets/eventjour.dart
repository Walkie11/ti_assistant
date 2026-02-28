import 'package:flutter/material.dart';
import 'package:ti_asistan/sreens/accueil.dart';
import 'package:ti_asistan/widgets/event.dart';
import 'package:ti_asistan/widgets/liveevent.dart';

class Eventjour extends StatefulWidget {
  Eventjour({super.key, required this.evenements});

  final List<Evenements> evenements;
  @override
  State<Eventjour> createState() => _EventjourState();
}

class _EventjourState extends State<Eventjour> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.5,
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 65, 57, 54),
        borderRadius: BorderRadius.circular(15),
      ),
      child: widget.evenements.isEmpty
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
              itemCount: widget.evenements.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      LiveEvent(
                        projet: widget.evenements[index].projet ?? "",
                        titre: widget.evenements[index].nom,
                        calendrier: widget.evenements[index].calendrier ?? "",
                        start: widget.evenements[index].start,
                        end: widget.evenements[index].end,
                      ),
                      SizedBox(height: 2),
                    ],
                  );
                }

                return Column(
                  children: [
                    Event(
                      titre: widget.evenements[index].nom,
                      start: widget.evenements[index].start,
                      end: widget.evenements[index].end,
                    ),
                    SizedBox(height: 2),
                  ],
                );
              },
            ),
    );
  }
}
