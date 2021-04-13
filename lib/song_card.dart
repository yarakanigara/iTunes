import 'package:flutter/material.dart';

class SongCard extends StatefulWidget {
  final Widget child;
  SongCard({Key key, @required this.child}) : super(key: key);
  _SongCardState createState() => _SongCardState();
}

class _SongCardState extends State<SongCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            child: Image(image: null),
          ), 
          Expanded(
            child: Column(
              children: [
                Text("Song Name"),
                Text("Artist"),
                Text("Album")
              ],
            ),
          )
        ],
      )
    );
  }
}
