
import 'package:flutter/material.dart';
import 'package:ti_asistan/objet/evenement.dart';
  import 'dart:math'; 

class Calendrier {
  final String nom;
  final List<Evenement> evenements;
  final Color couleur;
  bool estActive;

  Calendrier({
    required this.nom,
    required this.estActive,
    required this.evenements,
    required this.couleur,
  });
  factory Calendrier.fromJson(Map<String, dynamic> json) {
    return Calendrier(
      nom: json['nom'],
      estActive: json['estActive'],
      evenements: json['evenements'] != null
          ? (json['evenements'] as List)
                .map((e) => Evenement.fromJson(e))
                .toList()
          : [],
      couleur: Color(json['couleur'].replaceFirst('#', '0xff')),
    );
  }

Color getColorFromJson(String? hexString) {
  if (hexString == null || hexString.isEmpty) {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withValues(alpha: 1.0);
  }

  try {
    String formattedHex = hexString.replaceFirst('#', '');
    if (formattedHex.length == 6) {
      formattedHex = 'FF$formattedHex';
    }
    return Color(int.parse(formattedHex, radix: 16));
  } catch (e) {
    return Colors.grey; 
  }
}
}
