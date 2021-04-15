import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:i_tunes/models/ListOfSongs.dart';
import 'package:provider/provider.dart';


class MusicPlayer extends StatefulWidget {
  final track;
  MusicPlayer({Key key, this.track}) : super(key: key);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  bool playing = false;
  IconData playBtn = Icons.play_arrow;

  AudioPlayer _player;
  AudioCache cache;
  Duration position = new Duration();
  Duration duration = new Duration();

  @override
  void initState() {
    _player = new AudioPlayer();
    cache = new AudioCache(fixedPlayer: _player);
    super.initState();
  }

  void getTrack(dynamic track) async {
    if (playing) {
      var res = await _player.pause();
      if (res == 1) {
        setState(() {
          playing = false;
        });
      }
    } else {
      var res = await _player.play(track['previewUrl'], isLocal: true);
      if (res == 1) {
        setState(() {
          playing = true;
        });
      }
    }
    _player.onDurationChanged.listen((Duration d) {
      setState(() {
        duration = d;
      });
    });
    _player.onAudioPositionChanged.listen((Duration d) {
      setState(() {
        position = d;
      });
    });
  }

  void changeTrack(String change, BuildContext context) {
    if (change == "next") {
      var idxTrack = context.read<ListOfSongs>().indexTrack;
      if (idxTrack == context.read<ListOfSongs>().songs.length) {
        idxTrack = 0;
        context
            .read<ListOfSongs>()
            .setCurrentTrack(context.read<ListOfSongs>().songs[idxTrack]);
      }else {
        idxTrack = idxTrack+1;
        context
            .read<ListOfSongs>()
            .setCurrentTrack(context.read<ListOfSongs>().songs[idxTrack]);
      }
      context
            .read<ListOfSongs>()
            .setCurrentTrack(idxTrack);
    }
    if (change == "prev") {
      var idxTrack = context.read<ListOfSongs>().indexTrack;
      if (idxTrack == 0) {
        idxTrack = context.read<ListOfSongs>().songs.length - 1;
        context
            .read<ListOfSongs>()
            .setCurrentTrack(context.read<ListOfSongs>().songs[idxTrack]);
      }else {
        idxTrack = idxTrack-1;
        context
            .read<ListOfSongs>()
            .setCurrentTrack(context.read<ListOfSongs>().songs[idxTrack]);
      }
      context
            .read<ListOfSongs>()
            .setCurrentTrack(idxTrack);
    }
  }

  Widget musicSlider() {
    return SliderTheme(
        data: SliderThemeData(thumbColor: Colors.white, disabledThumbColor: Colors.white),
        child: Slider.adaptive(
          activeColor: Colors.black87,
          inactiveColor: Colors.black45,
          min: 0.0,
          max: duration.inSeconds.toDouble(),
          value: position.inSeconds.toDouble(),
          onChanged: (double value) {
            _player.seek(new Duration(seconds: value.toInt()));
          },
        )
        );
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
                    onPressed: () => {
                      changeTrack("prev", context)
                    }),
                IconButton(
                    icon: playing ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                    iconSize: 40,
                    color: Colors.black54,
                    onPressed: () =>
                        {getTrack(context.read<ListOfSongs>().currentTrack)}),
                IconButton(
                    icon: Icon(Icons.skip_next_sharp),
                    iconSize: 32,
                    color: Colors.black54,
                    onPressed: () => {changeTrack("next", context)})
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
