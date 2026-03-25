import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ti_asistan/Providers/CalendrierProvider.dart';
import 'package:ti_asistan/Providers/TacheProvider.dart';
import 'package:ti_asistan/Providers/authProvider.dart';
import 'package:ti_asistan/Providers/evenementProv.dart';
import 'package:ti_asistan/app/app.dart';
import 'package:provider/provider.dart';
import 'package:ti_asistan/Providers/speechProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Tacheprovider tacheprov = Tacheprovider();
  Calendrierprovider calprov = Calendrierprovider();
  await initializeDateFormatting('fr_FR', null);
  tacheprov.initialiser();
  calprov.initialiser();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Speechprovider()),
        ChangeNotifierProvider(create: (context) => Calendrierprovider()),
        ChangeNotifierProvider(create: (context) => Authprovider()),
        ChangeNotifierProvider(create: (context) => Tacheprovider()),
        ChangeNotifierProvider(create: (context) => EvenementProv()),
      ],
      child: const MyApp(),
    ),
  );
}
