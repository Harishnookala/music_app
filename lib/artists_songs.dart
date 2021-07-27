import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class ArtistsSongs extends StatefulWidget {
  String Artists_name;
  String number_of_songs;

  ArtistsSongs({this.Artists_name, this.number_of_songs});

  @override
  _ArtistsSongsState createState() =>
      _ArtistsSongsState(
          Artists_name: Artists_name, number_of_songs: number_of_songs);
}

class _ArtistsSongsState extends State<ArtistsSongs> {
  String Artists_name;
  String number_of_songs;
  List<SongInfo> songs;

  _ArtistsSongsState({this.Artists_name, this.number_of_songs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: FutureBuilder<List<SongInfo>>(
                future: FlutterAudioQuery()
                    .getSongsFromArtist(artist: Artists_name),
                builder: (context, snapshot) {
                  songs = snapshot.data;
                  int tracks = int.parse(number_of_songs);
                  return Container(
                    child: ListView.builder(
                        itemCount: tracks,
                        itemBuilder: (context, Index) {
                          SongInfo song_item = songs[Index];

                          return new Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (Index == 0)
                                  Container(
                                    margin:
                                    EdgeInsets.only(left: 5.3, right: 5.3),
                                    padding: EdgeInsets.only(
                                        top: 13.3, bottom: 15.3),
                                    child: Center(
                                      child: ClipOval(
                                        child: Image(
                                          image: song_item.albumArtwork != null
                                              ? FileImage(
                                              File(song_item.albumArtwork))
                                              : AssetImage(
                                              "Images/music_tone.jpg"),
                                        ),
                                      ),
                                    ),
                                  )
                                else
                                  Container(),
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 15.3, bottom: 15.3),
                                    child: ListTile(
                                      leading: ClipOval(
                                        child: Image(
                                          image: song_item.albumArtwork != null
                                              ? FileImage(
                                              File(song_item.albumArtwork))
                                              : AssetImage(
                                              "Images/music_tone.jpg"),
                                        ),
                                      ),
                                      title: Text(
                                        songs[Index].title,
                                      ),
                                      onTap: () {},
                                    ))
                              ],
                            ),
                          );
                        }),
                  );
                })));
  }
}
