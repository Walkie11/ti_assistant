import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ti_asistan/Providers/CalendrierProvider.dart';
import 'package:ti_asistan/app/app.dart';
import 'package:provider/provider.dart';
import 'package:ti_asistan/Providers/speechProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Speechprovider()),
        ChangeNotifierProvider(create: (context) => Calendrierprovider()),
      ],
      child: const MyApp(),
    ),
  );
}
