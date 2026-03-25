import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ti_asistan/Providers/TacheProvider.dart';
import 'package:ti_asistan/widgets/tacheWidget.dart';

enum Priorite { basse, normale, haute, urgent }

enum Statut { Annule, AFaire, Encours, Complete }

class Tache {
  String nom;
  String description;
  Priorite priorite;
  Statut statut;
  Tache({
    required this.nom,
    required this.description,
    required this.priorite,
    required this.statut,
  });
  factory Tache.fromJson(Map<String, dynamic> json) {
    return Tache(
      nom: json['nom'],
      description: json['description'] != null
          ? (json['description'])
          : "Sans description",
      priorite: Priorite.values.firstWhere(
        (e) => e.name == json['priorite'],
        orElse: () => Priorite.normale,
      ),
      statut: Statut.values.firstWhere(
        (e) => e.name == json['statut'],
        orElse: () => Statut.AFaire,
      ),
    );
  }
}

class TachesScreen extends StatefulWidget {
  const TachesScreen({super.key});

  @override
  State<TachesScreen> createState() => TachesScreenState();
}

class TachesScreenState extends State<TachesScreen> {
  Color _getCouleurPriorite(Priorite p) {
    switch (p) {
      case Priorite.urgent:
        return Colors.redAccent;
      case Priorite.haute:
        return Colors.orange;
      case Priorite.normale:
        return Colors.blue;
      case Priorite.basse:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color _getCouleurStatut(Statut p) {
    switch (p) {
      case Statut.Annule:
        return const Color.fromARGB(255, 173, 0, 0);
      case Statut.Encours:
        return const Color.fromARGB(255, 228, 114, 0);
      case Statut.AFaire:
        return const Color.fromARGB(255, 109, 109, 109);
      case Statut.Complete:
        return const Color.fromARGB(255, 0, 170, 9);
      default:
        return Colors.grey;
    }
  }

  IconData _getIconeStatut(Statut s) {
    switch (s) {
      case Statut.Encours:
        return Icons.hourglass_bottom;
      case Statut.Complete:
        return Icons.check_circle_rounded;
      case Statut.Annule:
        return Icons.cancel_rounded;
      case Statut.AFaire:
      default:
        return Icons.radio_button_unchecked;
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Tacheprovider>(context);
   
    if(prov.isLoading){
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } return Scaffold(
      appBar: AppBar(title: const Text('Mes Taches')),
      body: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 2),
        itemCount: prov.taches.length,
        itemBuilder: (context, index) {
          final t = prov.taches[index];
          return InkWell(
            onTap: () => {
              Navigator.push(
                context,
                PageRouteBuilder(
                  opaque: false,
                  barrierDismissible: true,
                  pageBuilder: (context, _, __) => Tachewidget(tache: t),
                ),
              ),
            },
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: Container(
                  width: 5,
                  decoration: BoxDecoration(
                    color: _getCouleurPriorite(t.priorite),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                title: Text(
                  t.nom,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: t.statut == Statut.Complete
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                subtitle: Text(t.description),
                trailing: Icon(
                  _getIconeStatut(t.statut),
                  color: _getCouleurStatut(t.statut),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
