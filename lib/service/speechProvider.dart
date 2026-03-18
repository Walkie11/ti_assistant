import 'package:flutter/widgets.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Speechprovider with ChangeNotifier {
  String text = "Appuyez pour parler122";
  String get transcription => text;
  SpeechToText speech = SpeechToText();

  void changerTexte(String nouveauTexte) {
    text = nouveauTexte;
    notifyListeners();
  }

  void startListening() async {
    changerTexte("yessss");
    await speech.listen(
      onResult: (result) {
        changerTexte(result.recognizedWords);
      },
    );
  }

  void stopListening() async {
    await speech.stop();
  }
}
