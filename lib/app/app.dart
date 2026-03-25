import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:ti_asistan/Providers/CalendrierProvider.dart';
import 'package:ti_asistan/Providers/authProvider.dart';
import 'package:ti_asistan/sreens/Accueil.dart';
import 'package:ti_asistan/sreens/calendrier_screen.dart';
import 'package:ti_asistan/sreens/connexionScreen.dart';
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
    super.initState(); 
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final apiService =
          Apiservice(); 
      apiService.initSignalR(context);
      apiService.startConnection();
    });
  }

  @override
  Widget build(BuildContext context) {
  
    return OverlaySupport.global(child: MaterialApp(

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
      initialRoute:'/accueil',
      routes: {
        // '/':(context)=> RacinePage(),
        '/accueil': (context) => Accueil(),
        '/calendrier': (context) => CalendrierScreen(),
        '/tache': (context) => TachesScreen(),
        '/projet': (context) => ProjetScreen(),
      },
    ));
  }
}
class RacinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final authProv = context.watch<Authprovider>();
    if (authProv.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return authProv.Connected ? const Accueil() : const Connexionscreen();
  }
}
