import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  late DateTime present = DateTime(0);
  @override
  void initState() {
    super.initState();
    // Met à jour l'heure chaque seconde automatiquement
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        // Vérifie que le widget est encore affiché
        setState(() {
          present = DateTime.now();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.40;
    var height = MediaQuery.of(context).size.height * 0.25;
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        border: Border(
          right: BorderSide(
            color: const Color.fromARGB(255, 83, 51, 51),
            width: 8,
          ),
          bottom: BorderSide.none,
          left: BorderSide.none,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              DateFormat('d MMMM', 'fr_FR').format(present),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: width * 0.09,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat("HH'h'm").format(present),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.2,
                    color: Colors.blueGrey,
                    letterSpacing: 1.2,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [Text(DateFormat('ss').format(present))],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
