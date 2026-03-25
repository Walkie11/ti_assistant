import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:ti_asistan/service/apiService.dart';

class Speechprovider with ChangeNotifier {
  String text = "Appuyez pour parler";
  bool available = false;
  bool _isListening = false;
  final SpeechToText _speech = SpeechToText();
  final Apiservice api = Apiservice();

  final ValueNotifier<String> speechTextNotifier = ValueNotifier("");

  Speechprovider() {
    _initSpeech();
  }

  void _initSpeech() async {
    available = await _speech.initialize();
    notifyListeners();
  }

  bool get isListening => _isListening;

  void startListening(BuildContext context) async {
    if (!available || _isListening) return;

    _isListening = true;
    speechTextNotifier.value = "Je vous écoute...";
    notifyListeners();

    showBottomSheet(
      context: context,
      backgroundColor:
          Colors.transparent, 
          elevation: 0, 
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(
            50,
          ), 
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30), 
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            children: [
              const SizedBox(height: 15),
              ValueListenableBuilder<String>(
                valueListenable: speechTextNotifier,
                builder: (context, value, child) {
                  return Text(value, textAlign: TextAlign.center);
                },
              ),
            ],
          ),
        );
      },
    );

    await _speech.listen(
      localeId: "fr_FR",
      onResult: (result) {
        speechTextNotifier.value = result.recognizedWords;
        text = result.recognizedWords;

        if (result.finalResult) {
          api.envoyerIntention(result.recognizedWords);
          Future.delayed(const Duration(seconds: 1), () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          });
        }
      },
    );
  }

  void stopListening() async {
    if (!_isListening) return;
    _isListening = false;
    await _speech.stop();
    notifyListeners();
  }
}
