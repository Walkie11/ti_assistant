import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width*0.40,
        height: MediaQuery.of(context).size.height * 0.25,
        margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
  topLeft: Radius.circular(15),
  topRight: Radius.circular(15),
  bottomRight: Radius.circular(15)
),
        border: Border(
          right:BorderSide(color:const Color.fromARGB(255, 83, 51, 51),width: 8 ),
          bottom: BorderSide.none,
          left: BorderSide.none,
        )
      ));
  }
}