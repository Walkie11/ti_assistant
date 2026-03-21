import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:ti_asistan/Providers/CalendrierProvider.dart';
import 'package:ti_asistan/objet/evenement.dart';
import 'package:ti_asistan/service/apiService.dart';
import 'package:ti_asistan/Providers/speechProvider.dart';
import 'package:ti_asistan/utiltaires/fablocation.dart';
import 'package:ti_asistan/widgets/bottomnavbar.dart';
import 'package:ti_asistan/widgets/eventjour.dart';
import 'package:ti_asistan/widgets/info.dart';
import 'package:ti_asistan/widgets/productivite.dart';
import 'package:ti_asistan/widgets/taches.dart';

class AccueilScreen extends StatefulWidget {
  const AccueilScreen({super.key});
  @override
  _AccueilScreenState createState() => _AccueilScreenState();
}

class _AccueilScreenState extends State<AccueilScreen> {
  final service = Apiservice();

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Calendrierprovider>(context);
    final maintenant = DateTime.now();

    List<Evenement> events = prov.evenements.where((event) {
      return event.debut.day == maintenant.day &&
          event.debut.month == maintenant.month &&
          event.debut.year == maintenant.year;
    }).toList();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(children: [Info(), SizedBox(height: 10), Productivite()]),
              SizedBox(width: 10),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Eventjour(),

                  if (events.length > 5)
                    Positioned(
                      bottom: -10,
                      right: -5,
                      child: Container(
                        alignment: Alignment.center,
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 209, 52, 46),
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
          Taches(),
        ],
      ),
    );
  }
}
