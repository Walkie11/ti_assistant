import 'package:flutter/material.dart';
import 'package:ti_asistan/sreens/calendrier_screen.dart';

class Bottomnavbar extends StatelessWidget {
  const Bottomnavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber,
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
              print("Home clicked");
            },
            icon: const Icon(Icons.construction),
          ),
          SizedBox(width: 80),
          IconButton(
            onPressed: () {
              print("Home clicked");
            },
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {
              print("Settings clicked");
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
