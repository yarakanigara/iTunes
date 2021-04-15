import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:i_tunes/music_player.dart';
import 'package:i_tunes/ListOfSongs.dart';
import 'package:provider/provider.dart';

import 'dart:convert' as convert;

import 'package:i_tunes/songs.dart';

void main() {
  runApp(MyApp());
}

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

  // // Pop-up music player
  // void showMusicPlayer(dynamic data) {
  //   // _settingModalBottomSheet(context);
  //   _scaffoldKey.currentState.showBottomSheet<Null>((BuildContext context) {
  //     return Container(
  //       width: double.infinity,
  //       decoration: BoxDecoration(color: Colors.black12),
  //       padding: EdgeInsets.all(16.0),
  //       child: MusicPlayer(
  //         track: data
  //       ),
  //       // child: Text(
  //       //   data.toString()
  //       // ),
  //     );
  //   });
  // }

  Future<dynamic> getArtists(String artist) async {
    var url = Uri.https(
        'itunes.apple.com', '/search', {'media': 'music', 'term': artist});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      dynamic jsonResponse =
          Map<String, dynamic>.from(convert.jsonDecode(response.body));
      print(jsonResponse);
      var itemCount = jsonResponse['resultCount'];
      print('Number of artist about http: $itemCount.');
      return jsonResponse['results'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => new ListOfSongs("", []),
        builder: (context, child) => Scaffold(
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
                        onSubmitted: (artist) => {
                          this.getArtists(artist).then((value) =>
                              context.read<ListOfSongs>().setListOfSongs(value))
                        },
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
                    // List Songs Section
                    Expanded(
                      child: Songs(
                        songs: context.read<ListOfSongs>().songs,
                        // playSong: showMusicPlayer,
                      ),
                    )
                  ],
                ),
              ),
              bottomSheet: context.watch<ListOfSongs>().currentTrack != null ? MusicPlayer():null,
            ));
  }
}
