import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioPlayer _player = AudioPlayer();

  // Da wir keine Assets im Projekt haben, nutzen wir System-Sounds oder 
  // vordefinierte kurze URLs für den Prototyp. 
  // Im echten Projekt sollten diese Dateien unter assets/audio/ liegen.
  
  static const String successUrl = 'https://assets.mixkit.co/active_storage/sfx/2568/2568-preview.mp3';
  static const String errorUrl = 'https://assets.mixkit.co/active_storage/sfx/2571/2571-preview.mp3';

  static Future<void> playSuccess() async {
    await _player.stop();
    await _player.play(UrlSource(successUrl));
  }

  static Future<void> playError() async {
    await _player.stop();
    await _player.play(UrlSource(errorUrl));
  }
}
