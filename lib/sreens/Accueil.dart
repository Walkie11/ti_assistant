import 'package:flutter/material.dart';
import 'package:ti_asistan/sreens/accueil_screen.dart';
import 'package:ti_asistan/utiltaires/fablocation.dart';
import 'package:ti_asistan/widgets/bottomnavbar.dart';
import 'package:ti_asistan/widgets/micro.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        
      ),
      floatingActionButton: Micro(),
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
