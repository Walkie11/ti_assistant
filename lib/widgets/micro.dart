import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ti_asistan/Providers/speechProvider.dart';

class Micro extends StatefulWidget {
  const Micro({super.key});

  @override
  State<Micro> createState() => _MicroState();
}

class _MicroState extends State<Micro> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 1.0), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0),weight: 20,), 
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.1),weight: 10,), 
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 30),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    final speechProvider = Provider.of<Speechprovider>(context);
    if (speechProvider.isListening) {
      _controller.repeat();
    } else {
      _controller.stop();
      _controller.reset();
    }
    bool isListening = speechProvider.isListening;
    return ScaleTransition(
      scale: _animation,
    
      child: GestureDetector(
        onTap: () => HapticFeedback.heavyImpact(),
        onLongPress: () {
          speechProvider.startListening();
        },
        onLongPressUp: () {
          speechProvider.stopListening();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: isListening ? 110 : 90,
          height: isListening ? 110 : 90,
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: isListening
                ? const Color.fromARGB(255, 95, 90, 90)
                : const Color.fromARGB(255, 66, 54, 17),
            elevation: isListening ? 0 : 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(55),
              side: BorderSide(color: Colors.white, width: 2 ),
            ),
            child: Icon(
              isListening? Icons.graphic_eq :Icons.mic, color: Colors.white, size: 40),
          ),
        ),
      )
    );
    
    
  }
}
