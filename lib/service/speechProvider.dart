import 'package:flutter/widgets.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Speechprovider with ChangeNotifier {
  String text = "Appuyez pour parler122";
  String get transcription => text;
  SpeechToText speech = SpeechToText();
  bool _isListening = false;
  bool get isListening => _isListening;
  void changerTexte(String nouveauTexte) {
    text = nouveauTexte;
    notifyListeners();
  }

  void startListening() async {
    _isListening = true;
    changerTexte("En ecoute");
    await speech.initialize();
    await speech.listen(
      onResult: (result) {
        changerTexte(result.recognizedWords);
      },
    );
  }

  void stopListening() async {
    changerTexte("");

    _isListening = false;
    await speech.stop();
  }
}
