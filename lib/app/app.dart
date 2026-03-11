import 'package:flutter/material.dart';
import 'package:ti_asistan/sreens/Accueil.dart';
import 'package:ti_asistan/sreens/calendrier_screen.dart';
import 'package:ti_asistan/sreens/projet_screen.dart';
import 'package:ti_asistan/sreens/taches_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ti Asistan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 202, 97, 12),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 10, 10, 10),
          brightness: Brightness.light
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 10,
          )
      ),
        initialRoute: '/',
        routes: {
          '/': (context) => Accueil(),
          '/calendrier': (context) => Calendrier(),
          '/tache':(context)=>TachesScreen(),
          '/projet':(context)=>ProjetScreen(),
        },
      
    );
  }
}
