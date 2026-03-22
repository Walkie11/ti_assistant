import 'package:flutter/material.dart';

class Connexionscreen extends StatelessWidget {
  const Connexionscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Card(
          
            elevation: 4, // L'intensité de l'ombre
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Coins arrondis
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Titre de la tâche", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Description de l'événement..."),
                ],
              ),
            ),
          
        )        
        )
    );
  }
}