import 'package:flutter/material.dart';
import 'package:ti_asistan/app/app.dart';
import 'package:provider/provider.dart';
import 'package:ti_asistan/service/speechProvider.dart';

void main() {
    
  runApp(
    ChangeNotifierProvider(
      create:(context) =>Speechprovider(),
      child:const MyApp()));
}


