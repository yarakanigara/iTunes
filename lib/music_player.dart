import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'dart:io';

class MusicPlayer extends StatefulWidget {
  MusicPlayer({Key key}) : super(key: key);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  bool playing = false;
  IconData playBtn = Icons.play_arrow;

  AudioPlayer _player;
  AudioCache cache;
  Duration position = new Duration();
  Duration musicLength = new Duration();

  @override
  void initState() {
    _player = new AudioPlayer();
    cache = new AudioCache(fixedPlayer: _player);
  }
  
  Widget musicSlider() {
    return SliderTheme(
      data: SliderThemeData(
        thumbColor: Colors.white,
        disabledThumbColor: Colors.white
      ),
      child: Slider.adaptive(
        activeColor: Colors.black87,
        inactiveColor: Colors.black45,
        value: position.inSeconds.toDouble(),
        max: musicLength.inSeconds.toDouble(),
        onChanged: (value) {
          seekToSec(value.toInt());
        },
      )
    );
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(Icons.skip_previous_sharp),
                    iconSize: 32,
                    color: Colors.black54,
                    onPressed: () => {}),
                IconButton(
                    icon: Icon(Icons.play_arrow),
                    iconSize: 40,
                    color: Colors.black54,
                    onPressed: () => {
                          if (!playing)
                            {
                              setState(() {
                                playBtn = Icons.pause;
                                playing = true;
                              })
                            }
                          else
                            {
                              setState(() {
                                playBtn = Icons.play_arrow;
                                playing = false;
                              })
                            }
                        }),
                IconButton(
                    icon: Icon(Icons.skip_next_sharp),
                    iconSize: 32,
                    color: Colors.black54,
                    onPressed: () => {})
              ],
            ),
            Container(
              child: musicSlider(),
              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
              decoration: BoxDecoration(),
            )
          ],
        ),
      ),
    );
  }
}
