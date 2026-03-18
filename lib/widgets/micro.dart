import 'package:flutter/material.dart';
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
    return GestureDetector(
      onLongPress: speechProvider.startListening,
      onLongPressUp: speechProvider.stopListening,
      child: FloatingActionButton.large(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 66, 54, 17),
        elevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(color: Colors.white, width: 8),
        ),
        child: Icon(Icons.mic, color: Colors.white),
      ),
    );
  }
}
