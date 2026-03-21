import 'package:flutter/material.dart';
import 'package:ti_asistan/Providers/CalendrierProvider.dart';
import 'package:ti_asistan/sreens/Accueil.dart';
import 'package:ti_asistan/sreens/calendrier_screen.dart';
import 'package:ti_asistan/sreens/projet_screen.dart';
import 'package:ti_asistan/sreens/taches_screen.dart';
import 'package:ti_asistan/service/apiService.dart';
import 'package:ti_asistan/variables.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState(); // Maintenant cela fonctionnera

    // On attend que le premier frame soit dessiné pour avoir un contexte valide
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final apiService =
          Apiservice(); // Assurez-vous que la classe s'appelle Apiservice ou ApiService
      apiService.initSignalR(context);
      apiService.startConnection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Ti Asistan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 202, 97, 12),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 10, 10, 10),
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 10,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Accueil(),
        '/calendrier': (context) => CalendrierScreen(),
        '/tache': (context) => TachesScreen(),
        '/projet': (context) => ProjetScreen(),
      },
    );
  }
}
