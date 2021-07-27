import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import 'album_songs.dart';

class Albums extends StatefulWidget {
  @override
  _AlbumsState createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  String album_id;
  String number_of_songs;
  List albums = [];
  String image;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: FlutterAudioQuery()
                .getAlbums(sortType: AlbumSortType.CURRENT_IDs_ORDER),
            builder: (context, snapshot) {
              List<AlbumInfo> albums = snapshot.data;
              if (snapshot.hasData) {
                return GridView.builder(
                    itemCount: albums.length,
                    semanticChildCount: 2,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 250,
                        childAspectRatio: 4 / 6,
                        mainAxisExtent: 265,
                        mainAxisSpacing: 10),
                    itemBuilder: (context, Index) {
                      return InkWell(
                        highlightColor: Colors.cyanAccent,
                        child: new Card(
                          elevation: 2.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image(
                                height: 150,
                                width: 250,
                                fit: BoxFit.fitWidth,
                                image: albums[Index].albumArt != null
                                    ? FileImage(File(albums[Index].albumArt))
                                    : AssetImage("Images/music_tone.jpg"),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 5.3, left: 9.6,bottom: 12.3),
                                  child: Text(
                                    albums[Index].title,
                                    style: TextStyle(color: Colors.black),
                                  )),
                              Container(
                                margin: EdgeInsets.only(top: 5.3, left: 9.6),
                                child: Text(
                                  albums[Index].artist,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 14),
                                ),
                              ),


                            ],
                          ),
                        ),
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                Albumsongs(album_id: albums[Index].id,
                                  number_of_songs:albums[Index].numberOfSongs,

                                )),
                          );                        },
                      );
                    });
              } else if (snapshot.hasError) {
                return new Text("does not");
              }
              return Container();
            }));
  }
}
