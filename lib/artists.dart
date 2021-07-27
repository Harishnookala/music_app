import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import 'artists_songs.dart';

class Artists extends StatefulWidget {
  @override
  ArtistsState createState() => ArtistsState();
}

class ArtistsState extends State<Artists> {
  String Artists_name;
  String number_of_songs;
  List albums = [];
  String image;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<List<ArtistInfo>>(
            future: FlutterAudioQuery()
                .getArtists(sortType: ArtistSortType.MORE_ALBUMS_NUMBER_FIRST),
            builder: (context, snapshot) {
              List<ArtistInfo> artists = snapshot.data;
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: artists.length,
                    itemBuilder: (context, Index) {
                      return InkWell(
                        highlightColor: Colors.cyanAccent,
                        child: new Card(
                          elevation: 2.5,
                          margin: EdgeInsets.only(bottom: 15.3, top: 5.9),
                          child: Container(
                            margin: EdgeInsets.all(12.3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.fitWidth,
                                    image: artists[Index].artistArtPath != null
                                        ? FileImage(
                                        File(artists[Index].artistArtPath))
                                        : AssetImage("Images/music_tone.jpg")),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              top: 5.3,
                                              left: 9.6,
                                              bottom: 12.3),
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.7,
                                          child: artists[Index].name ==
                                              "<unknown>" ? Text(
                                              "Unknown Artists") : Text(
                                            artists[Index].name,
                                            style: TextStyle(
                                                color: Colors.black),
                                          )),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Center(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 5.3, left: 9.6),
                                            child: Text(
                                              artists[Index].numberOfAlbums +
                                                  "  Albums ",
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 5.3, left: 9.6),
                                            child: Text("--> " +
                                                artists[Index].numberOfTracks +
                                                " songs",
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ArtistsSongs(
                                        Artists_name: artists[Index].name,
                                        number_of_songs: artists[Index]
                                            .numberOfTracks
                                    )),
                          );
                        },
                      );
                    });
              } else if (snapshot.hasError) {
                return new Text("does not");
              }
              return Center(
                child: Text(".... Loading ....",
                  style: TextStyle(color: Colors.deepOrangeAccent),),
              );
            }));
  }
}
