import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class Albumsongs extends StatefulWidget {
  String album_id;
  String number_of_songs;
  Albumsongs({this.album_id,this.number_of_songs});
  @override
  AlbumsongsState createState() => AlbumsongsState(album_id: album_id,number_of_songs: number_of_songs);
}

class AlbumsongsState extends State<Albumsongs> {
  String album_id;
  String number_of_songs;
  int tracks;
  List<SongInfo>songs;
  AlbumsongsState({this.album_id,this.number_of_songs});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: FutureBuilder(
              future: FlutterAudioQuery().getSongsFromAlbum(
                  albumId: album_id),
              builder: (context, snapshot) {
                songs = snapshot.data;
                tracks  = int.parse(number_of_songs);
                return Container(
                  child: ListView.builder(
                      itemCount:tracks ,
                      itemBuilder: (context, Index) {
                        print(songs[0].albumArtwork);

                        return new Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (Index == 0)
                                Container(
                                  margin:
                                      EdgeInsets.only(left: 5.3, right: 5.3),
                                  padding:
                                      EdgeInsets.only(top: 13.3, bottom: 15.3),
                                  child: Center(
                                    child: ClipOval(
                                      child: (songs[Index].albumArtwork!=null)?Image(
                                          image: FileImage(File(songs[Index].albumArtwork))):Image.asset("Images/music_tone.jpg"),
                                    ),
                                  ),
                                )
                              else
                                Container(),
                              Container(
                                  margin:
                                      EdgeInsets.only(left: 15.3, bottom: 15.3),
                                  child: ListTile(
                                    leading: ClipOval(
                                      child: Image(
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.fitWidth,
                                          image: songs[Index].albumArtwork!=null
                                              ? FileImage(File(
                                                  songs[Index].albumArtwork))
                                              : AssetImage(
                                                  "Images/music_tone.jpg")),
                                    ),
                                    title: Text(
                                      songs[Index].title,
                                    ),
                                    onTap: () {


                                    },
                                  ))
                            ],
                          ),
                        );
                      }),
                );
              })),
    );
  }
}
