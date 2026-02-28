import 'package:flutter/material.dart';

class Bottomnavbar extends StatelessWidget {
  const Bottomnavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceAround, // espace entre les icônes
      children: [
        IconButton(
          onPressed: () {
            print("Event clicked");
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
    );
  }
}
