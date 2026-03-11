import 'package:flutter/material.dart';
import 'package:ti_asistan/sreens/accueil_screen.dart';
import 'package:ti_asistan/utiltaires/fablocation.dart';
import 'package:ti_asistan/widgets/bottomnavbar.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        child: FloatingActionButton.large(
          onPressed: () {
          },

          backgroundColor: const Color.fromARGB(255, 66, 54, 17),
          elevation: 0,
          highlightElevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(color: Colors.white, width: 8),
          ),
          child: Icon(Icons.mic, color: Colors.white),
        ),
      ),
      body:AccueilScreen(),
      floatingActionButtonLocation: CustomFabLocation(),
      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.only(bottom: 15, top: 5, right: 10, left: 10),
        
        child: Bottomnavbar()
      ),
    );
  }
}
