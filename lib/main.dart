import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                onEditingComplete: searchArtistSongs(),
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
            // Container(
            //   padding: getArtist() ? EdgeInsets.all(0) : EdgeInsets.fromLTRB(24, 8, 24, 8),
            //   decoration: BoxDecoration(
            //     border: BorderDirectional(
            //         bottom: BorderSide(color: Colors.black38)),
            //     color: Colors.black12,
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: getArtist() ? [] : [
            //       Text(
            //         "Artist Name",
            //         overflow: TextOverflow.fade,
            //         maxLines: 1,
            //         softWrap: false,
            //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            //       ),
            //       Text(
            //         "XX Songs",
            //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Songs([{},{},{},{},{}])
                ],    
              ),
            ),
            Container()
          ],
        ),
      ),
    );
  }
  void searchArtists(String artist) async {
    var url =
      Uri.https('https://itunes.apple.com', '/lookup', {'q': '{http}'});

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var itemCount = jsonResponse['totalItems'];
      print('Number of books about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  listOfArtist() {}
  getArtist<bool>() {
    return true;
  }
}
