import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ti_asistan/service/speechProvider.dart';

class Micro extends StatefulWidget {
  const Micro({super.key});

  @override
  State<Micro> createState() => _MicroState();
}

class _MicroState extends State<Micro> {
  @override
  Widget build(BuildContext context) {
    final speechProvider = Provider.of<Speechprovider>(context, listen: false);
    final bool isListening = speechProvider.isListening;
    return GestureDetector(
      onLongPress: () {
        HapticFeedback.heavyImpact();
        speechProvider.startListening();
      },
      onLongPressUp: () {
        speechProvider.stopListening();
      },
     child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        // On augmente la taille globale ici (ex: 100 ou 120 pixels)
        width: isListening ? 110 : 100,
        height: isListening ? 110 : 100,
        child: FloatingActionButton(
          // On retire .large pour contrôler via le Container
          onPressed: () {},
          backgroundColor: isListening
              ? Colors.red[900]
              : const Color.fromARGB(255, 66, 54, 17),
          elevation: isListening ? 0 : 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              55,
            ), // Moitié de la largeur pour un cercle parfait
            side: BorderSide(
              color: Colors.white,
              width: isListening
                  ? 10
                  : 6, // Bordure plus épaisse quand on appuie
            ),
          ),
          child: Icon(
            isListening ? Icons.graphic_eq : Icons.mic,
            color: Colors.white,
            size: 40, // On augmente aussi la taille de l'icône
          ),
        ),
      ),
    );
  }
}
