import 'package:flutter/material.dart';

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
      // appBar: AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      // title: Text("iTunes"),
      // centerTitle: true,
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(
                  50, 50, 50, 50 - MediaQuery.of(context).padding.top),
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
                      borderSide: new BorderSide(color: Colors.blue)
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10)),
              ),
              decoration: BoxDecoration(
                  border: BorderDirectional(
                      bottom: BorderSide(color: Colors.black)),
                  color: Colors.black12
                  // boxShadow: [BoxShadow(color: Colors.black)]
                  ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [],
              ),
            ),
            Container()
          ],
        ),
      ),
    );
  }

  searchArtistSongs() {}
  listOfArtist() {}
}
