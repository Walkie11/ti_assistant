import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:ti_asistan/sreens/calendrier_screen.dart';
import 'package:ti_asistan/Providers/authProvider.dart';
import 'package:provider/provider.dart';

class Bottomnavbar extends StatelessWidget {
  const Bottomnavbar({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Authprovider>(context);
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 196, 159, 59),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CalendrierScreen(),
                ),
              );
            },
            icon: const Icon(Icons.event),
          ),
          IconButton(
            onPressed: () {
              toast("Projet non implemente");
            },
            icon: const Icon(Icons.construction),
          ),
          SizedBox(width: 80),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/tache');
            },
            icon: const Icon(Icons.assignment),
          ),
          IconButton(
            onPressed: () {
              toast("parmetres non implemente");

            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
