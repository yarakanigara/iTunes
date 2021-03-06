import 'package:flutter/material.dart';

class ListOfSongs extends ChangeNotifier {
  String _artistSearch;
  String get artistSearch => _artistSearch;

  List<dynamic> _songs;
  List<dynamic> get songs => _songs;

  dynamic _currentTrack;
  dynamic get currentTrack => _currentTrack;

  int _indexTrack;
  int get indexTrack => _indexTrack;

  ListOfSongs(this._artistSearch, this._songs);

  void setArtistSearch(String val) {
    this._artistSearch = val;
    notifyListeners();
  }

  void setListOfSongs(List<dynamic> val) {
    this._songs = val;
    notifyListeners();
  }

  void setCurrentTrack(dynamic val) {
    this._currentTrack = val;
    notifyListeners();
  }
  
  void setIndexTrack(int val) {
    this._indexTrack = val;
    notifyListeners();
  }

}
