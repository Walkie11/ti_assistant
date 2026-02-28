import 'package:flutter/material.dart';
import 'package:ti_asistan/widgets/tachesview.dart';

class Taches extends StatelessWidget {
  const Taches({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width*0.95,
      constraints: BoxConstraints(
        maxHeight:MediaQuery.of(context).size.height*0.3 ,
      ),
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Tachesview(),
    );
  }
}