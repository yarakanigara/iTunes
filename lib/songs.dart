import 'package:flutter/material.dart';
import 'package:i_tunes/ListOfSongs.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';


class Songs extends StatefulWidget {
  final songs;
  final playSong;
  Songs({Key key, this.songs, this.playSong}) : super(key: key);
  _SongsState createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  List<Object> songs = [];

  @override
  void initState() {
    songs.add(widget.songs);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: context.watch<ListOfSongs>().songs.length,
        itemBuilder: (context, index) => Card(
            color: (
              context.read<ListOfSongs>().currentTrack != null ?  
              context.read<ListOfSongs>().currentTrack['trackId'] == context.read<ListOfSongs>().songs[index]['trackId'] ? Colors.white10 : Colors.white70 : Colors.white70
            ),
            margin: EdgeInsets.all(0),
            child: InkWell(
                onTap: () {
                  widget.playSong(context.read<ListOfSongs>().songs[index]);
                  context.read<ListOfSongs>().setCurrentTrack(context.read<ListOfSongs>().songs[index]);
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(24,8,24,8),
                  child: Row(
                    children: [
                      Container( 
                        padding: EdgeInsets.fromLTRB(0, 0, 24, 0),
                        child: Image(
                          image: NetworkImage(context.read<ListOfSongs>().songs[index]['artworkUrl100'] ), 
                          height: 64,
                          width: 64,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.read<ListOfSongs>().songs[index]['trackName']  != null ? context.read<ListOfSongs>().songs[index]['trackName']: ""
                            ),
                            Text(
                              context.read<ListOfSongs>().songs[index]['artistName'] != null ? context.read<ListOfSongs>().songs[index]['artistName']: ""
                            ),
                            Text(
                              context.read<ListOfSongs>().songs[index]['collectionName'] != null ? context.read<ListOfSongs>().songs[index]['collectionName']: ""
                            ),
                          ],
                        )
                      ),
                      Container (
                        height: 50,
                        width: 50,
                        child: 
                        context.read<ListOfSongs>().currentTrack != null ?  
                        context.read<ListOfSongs>().currentTrack['trackId'] == context.read<ListOfSongs>().songs[index]['trackId'] ? Lottie.asset('assets/lottie/56202-soundwave-loader.json') : null : null,
                      )
                    ],
                  ),
                )
              )
            ),
    );
  }
}
