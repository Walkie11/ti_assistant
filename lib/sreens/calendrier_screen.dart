import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ti_asistan/Providers/CalendrierProvider.dart';
import 'package:ti_asistan/Providers/evenementProv.dart';
import 'package:ti_asistan/objet/calendrier.dart';
import 'package:ti_asistan/widgets/evenement.dart';
import 'package:ti_asistan/widgets/micro.dart';

class CalendrierScreen extends StatefulWidget {
  const CalendrierScreen({super.key});

  @override
  State<CalendrierScreen> createState() => _CalendrierScreenState();
}

class _CalendrierScreenState extends State<CalendrierScreen> {
  // On initialise 'present' à aujourd'hui (00:00:00) pour faciliter les comparaisons
  DateTime present = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  void passer(int num) {
    // ✅ Correction : setState est indispensable pour rafraîchir l'UI
    setState(() {
      present = present.add(Duration(days: num));
    });
  }

  // Fonction utilitaire pour vérifier si deux dates sont le même jour
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    final provEvent = Provider.of<EvenementProv>(context);
    final provCalendrier = Provider.of<Calendrierprovider>(context);

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // On définit des dimensions plus stables
    final double itemWidth = screenWidth * 0.35;
    final double hauteurTotaleZone = screenHeight * 0.85;
    final double hauteurHeure = hauteurTotaleZone / 24;

    // Calcul du premier jour de la semaine (Lundi)
    var premierJour = present.subtract(Duration(days: present.weekday - 1));

    // Génération des 7 jours de la semaine affichée
    List<DateTime> datesJrs = List.generate(
      7,
      (index) => premierJour.add(Duration(days: index)),
    );

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: (args != null || provCalendrier.calendriers.isEmpty)
            ? []
            : [
                PopupMenuButton<Calendrier>(
                  icon: const Icon(Icons.filter_list),
                  onSelected: (Calendrier cal) =>
                      provCalendrier.filtrerCalendrier(cal.nom),
                  itemBuilder: (context) =>
                      provCalendrier.calendriers.map((cal) {
                        return CheckedPopupMenuItem<Calendrier>(
                          value: cal,
                          checked: cal.estActive,
                          child: Text(cal.nom),
                        );
                      }).toList(),
                ),
              ],
        title: FittedBox(
          // ✅ Empêche le titre de déborder sur mobile
          fit: BoxFit.scaleDown,
          child: Row(
            children: [
              IconButton(
                onPressed: () => passer(-7),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              const Text("Semaine du "),
              Text(DateFormat('d MMM', 'fr_FR').format(premierJour)),
              const Text(" - "),
              Text(
                DateFormat(
                  'd MMM',
                  'fr_FR',
                ).format(premierJour.add(const Duration(days: 6))),
              ),
              IconButton(
                onPressed: () => passer(7),
                icon: const Icon(Icons.arrow_forward_ios_outlined),
              ),
            ],
          ),
        ),
        elevation: 0,
      ),
      floatingActionButton: const Micro(),
      body: Row(
        children: [
          // Colonne des heures à gauche
          SizedBox(
            width: screenWidth * 0.12,
            child: Column(
              children: [
                const SizedBox(height: 50), // Aligné avec l'en-tête
                Expanded(
                  child: ListView.builder(
                    itemCount: 24,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) => SizedBox(
                      height: hauteurHeure,
                      child: Center(
                        child: Text(
                          "$i:00",
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Stack(
              children: [
                ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const VerticalDivider(width: 2, color: Colors.black12),
                  itemCount: 7,
                  itemBuilder: (context, dayIndex) {
                    final DateTime jour = datesJrs[dayIndex];
                    final bool estAujourdhui = isSameDay(jour, DateTime.now());

                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: itemWidth,
                          height: 50,
                          color: estAujourdhui
                              ? const Color.fromARGB(
                                  255,
                                  161,
                                  138,
                                  3,
                                ).withValues(alpha: 0.6)
                              : const Color.fromARGB(255, 48, 47, 47),
                          child: Text(
                            DateFormat(
                              'E d',
                              'fr_FR',
                            ).format(jour).toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: estAujourdhui
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Expanded(
                          child: Container(
                            width: itemWidth,
                            color: const Color.fromARGB(255, 43, 43, 40),
                            child: Stack(
                              children: provEvent.objets
                                  .where((event) {
                                    return isSameDay(event.debut, jour) ||
                                        isSameDay(event.fin, jour);
                                  })
                                  .map((event) {
                                    double start = event.debut.day == jour.day
                                        ? event.debut.hour +
                                              (event.debut.minute / 60.0)
                                        : 0.0;
                                    double end = event.fin.day == jour.day
                                        ? event.fin.hour +
                                              (event.fin.minute / 60.0)
                                        : 24.0;

                                    return Positioned(
                                      top: start * hauteurHeure,
                                      left: 2,
                                      right: 2,
                                      height: (end - start) * hauteurHeure,
                                      child: EvenementWidget(evenement: event),
                                    );
                                  })
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                Positioned(
                  top:
                      50 +
                      (hauteurHeure *
                          (DateTime.now().hour + DateTime.now().minute / 60)),
                  left: 0,
                  right: 0,
                  child: IgnorePointer(
                    child: Container(
                      height: 2,
                      color: Colors.amber.withValues(alpha: 0.8),
                    ),
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
