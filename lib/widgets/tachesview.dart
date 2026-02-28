import 'package:flutter/material.dart';

class Tachesview extends StatefulWidget {
  const Tachesview({super.key});

  @override
  State<Tachesview> createState() => _TachesviewState();
}

class _TachesviewState extends State<Tachesview> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Mes Tâches"),
        Expanded(
          child:ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.check_box),
              title: const Text(''),
              subtitle: const Text('Nom, avatar, préférences'),
              onTap: () {
                // Action au tap
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Profil tap')));
              },
            );
          },
        ),)
      ],
    );
  }
}
