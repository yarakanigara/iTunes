import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audio_cache.dart' as audiocache;
import 'package:audioplayers/audioplayers.dart' as audioplayers;

import 'dart:convert' as convert;
import 'dart:async' as async;
import 'dart:io' as io;


import 'package:i_tunes/songs.dart';

void main() {
  runApp(MyApp());
}

var itemCount = 20;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iTunes',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // Pop-up music player
  void showMusicPlayer(Object data) {
    // _settingModalBottomSheet(context);
    _scaffoldKey.currentState.showBottomSheet<Null>((BuildContext context) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.lightBlue ),
        padding: EdgeInsets.all(16.0),
        child: Text("asdasd"),
      );
    });     
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Search Artist Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(
                  48, 48, 48, 48 - MediaQuery.of(context).padding.top),
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
              child: TextField(
                maxLines: 1,
                style: TextStyle(backgroundColor: Colors.white),
                autofillHints: listOfArtist(),
                onSubmitted: (artist) => {this.searchArtists(artist)},
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Search Artists',
                    counterText: "",
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.blue)),
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8)),
              ),
            ),
            // Search Artist Section - END
            // List Songs Section
            Expanded(
              child: Songs(data: [{}, {}, {}], playSong: showMusicPlayer),
            ),
            // List Songs Section - END
            // Music Player Section
            Container()
            // Music Player Section - END
          ],
        ),
      ),
    );
  }

void _settingModalBottomSheet(context){
    showModalBottomSheet(
      elevation: 100,
      context: context,
      builder: (BuildContext bc){
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                leading: new Icon(Icons.music_note),
                title: new Text('Music'),
                onTap: () => {}          
              ),  
              new ListTile(
                leading: new Icon(Icons.videocam),
                title: new Text('Video'),
                onTap: () => {},          
              ),
            ],
          ),
        );
        }
    );
  }

  void searchArtists(String artist) async {
    var url = Uri.https('itunes.apple.com', '/lookup', {'artistName': artist});
    print(artist);
    print(url);
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var itemCount = jsonResponse;
      print('Number of artist about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  listOfArtist() {}
  getArtist<bool>() {
    return true;
  }
}
