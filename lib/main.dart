import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ti_asistan/app/app.dart';
import 'package:provider/provider.dart';
import 'package:ti_asistan/service/speechProvider.dart';

void main() async {
  await initializeDateFormatting('fr_FR', null);

  runApp(
    ChangeNotifierProvider(
      create: (context) => Speechprovider(),
      child: const MyApp(),
    ),
  );
}
