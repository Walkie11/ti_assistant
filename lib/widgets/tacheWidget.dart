import 'package:flutter/material.dart';
import 'package:ti_asistan/sreens/taches_screen.dart';

class Tachewidget extends StatelessWidget {
  final Tache tache;
  const Tachewidget({super.key, required this.tache});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(97, 0, 0, 0),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize:
                    MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(
                      tache.nom,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(tache.description),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Fermer"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
