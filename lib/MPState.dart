import 'package:flutter/material.dart';

class MPState extends ChangeNotifier {
  bool _playing = false;
  bool get playing => _playing;

  dynamic _currentTrack;
  dynamic get currentTrack => _currentTrack;

  Duration _position;
  Duration get position => _position;

  Duration _duration; 
  Duration get duration => _duration;

  MPState(this._currentTrack);

  void setPlaying(bool val) {
    this._playing = val;
    notifyListeners();
  }
  
  void setCurrentTrack(dynamic val) {
    this._currentTrack = val;
    notifyListeners();
  }
}
