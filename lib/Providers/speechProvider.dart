import 'package:flutter/widgets.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:ti_asistan/service/apiService.dart';

class Speechprovider with ChangeNotifier {
  String text = "Appuyez pour parler122";
  final SpeechToText _speech = SpeechToText();
  
  var api= new Apiservice();
  String get transcription => text;
  SpeechToText speech = SpeechToText();
  bool _isListening = false;
  bool get isListening => _isListening;
  void changerTexte(String nouveauTexte) {
    text = nouveauTexte;
    api.envoyerIntention(text);
    notifyListeners();
  }

  void startListening() async {
    bool available = await _speech.initialize(
      onError: (val) => print('Error: $val'),
      onStatus: (val) => print('Status: $val'),
    );

    if (available) {
      _isListening = true;
      notifyListeners();

    await speech.listen(
      onResult: (result) {
        if (result.finalResult) {
            api.envoyerIntention(result.recognizedWords);
          }
          notifyListeners();
        changerTexte(result.recognizedWords);
      },
      localeId: "fr_FR",
    );
    notifyListeners();
  }}


  void stopListening() async {
    changerTexte("");

    _isListening = false;
    notifyListeners();
    await speech.stop();
  }

}