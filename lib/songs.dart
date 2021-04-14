import 'package:flutter/material.dart';

class Songs extends StatefulWidget {
  final List<Object> data;
  final playSong;
  Songs({Key key, this.data, this.playSong}) : super(key: key);
  _SongsState createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  List<Object> songs = [];

  @override
  void initState() {
    songs.add(widget.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: widget.data.length,
      itemBuilder: (context, index) => Card(
          margin: EdgeInsets.all(0),
          child: InkWell(
              onTap: () { 
                widget.playSong(widget.key.toString());
              },
              child: Container(
                padding: EdgeInsets.all(20),
                child: Text("Hellow"),
              ))),
    );
  }
}
