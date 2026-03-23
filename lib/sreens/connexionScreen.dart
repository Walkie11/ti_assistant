import 'package:flutter/material.dart';
import 'package:ti_asistan/widgets/formConnexion.dart';
import 'package:ti_asistan/widgets/formInscription.dart';
import 'package:ti_asistan/widgets/ongletButton.dart';

class Connexionscreen extends StatefulWidget {
  const Connexionscreen({super.key});
  @override
  _ConnexionscreenState createState() => _ConnexionscreenState();
}

class _ConnexionscreenState extends State<Connexionscreen> {
    bool senregistre = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 100),
          
          child: Card(
            color: const Color.fromARGB(255, 192, 177, 154),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                     
                      ongletButton(
                        () {
                          setState(() => senregistre = !senregistre);
                          
                        },
                        'Connexion',
                        !senregistre,
                      ),
                      ongletButton(
                        () {
                          setState(() => senregistre = !senregistre);
                        },
                        'Inscription',
                        senregistre,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 50),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 100),
                        child: senregistre? ConnexionForm():InscriptionForm(),
                      ),
                      const SizedBox(height: 50),
                    ],
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
