import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ti_asistan/Providers/TacheProvider.dart';
import 'package:ti_asistan/sreens/taches_screen.dart';
import 'package:ti_asistan/widgets/tacheWidget.dart';

class MesTaches extends StatelessWidget {
  const MesTaches({super.key});

  @override
  Widget build(BuildContext context) {
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

    final prov = Provider.of<Tacheprovider>(context);
    final taches = prov.taches.where(
      (t) => t.statut == Statut.AFaire || t.statut == Statut.Encours,
    ).toList();

    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.3,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 130, 177, 170),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text("Taches",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24
          ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: taches.length,
              separatorBuilder: (context, index) => const Divider(
                height: 1,
                thickness: 1,
                indent: 50,
                endIndent: 16,
                color: Colors.grey,
              ),
              itemBuilder: (context, index) {
                var tache = taches[index];
                return ListTile(
                  leading: Icon(_getIconeStatut(tache.statut)),
                  title: Text(tache.nom),
                  subtitle: tache.description.isNotEmpty
                      ? Text(
                          tache.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      : null,
                  onTap: () => {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        opaque: false,
                        barrierDismissible: true,
                        pageBuilder: (context, _, __) =>
                            Tachewidget(tache: tache),
                      ),
                    ),
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
