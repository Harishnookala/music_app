import 'dart:core';
import 'dart:io';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/cupertino.dart';

import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'widget.dart';

class SongWidget extends StatefulWidget {
  final List<SongInfo> songList;

  SongWidget({@required this.songList});

  @override
  _SongWidgetState createState() => _SongWidgetState();


}

class _SongWidgetState extends State<SongWidget> {
  List albums = [];

  List dirpaths = [];

  @override
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.songList.length,
      itemBuilder: (context, Index) {
        List<SongInfo> song = widget.songList;

        if (song[Index].displayName.contains(".mp3")) {
          return Container(
              margin: EdgeInsets.all(2.3),
              child: InkWell(
                child: new Card(
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image(
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          image: song[Index].albumArtwork != null ? FileImage(
                              File(song[Index].albumArtwork)) :
                          AssetImage("Images/music_tone.jpg"),
                        ),

                      ),
                      Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 16.3, left: 16.3, bottom: 16.3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(song[Index].title),
                                Container(
                                  margin: EdgeInsets.only(top: 4),
                                  child: Text("Artist: ${song[Index].artist}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: Text("Album: ${song[Index].album}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                          )),

                    ],
                  ),
                ),
                onTap: () {
                  audioManagerInstance
                      .start(
                      "file://${song[Index].filePath}", song[Index].title,
                      desc: song[Index].displayName,
                      auto: true,
                      cover: song[Index].albumArtwork)
                      .then((err) {

                  });
                },
              ));
        } else {
          return SizedBox();
        }
      },
    );
  }


  static String parseToMinutesSeconds(int ms) {
    String data;
    Duration duration = Duration(milliseconds: ms);

    int minutes = duration.inMinutes;
    int seconds = (duration.inSeconds) - (minutes * 60);

    data = minutes.toString() + ":";
    if (seconds <= 9) data += "0";

    data += seconds.toString();
    return data;
  }


}




class Songs{
  String album_name;
  String title;

  Songs({this.album_name,this.title});
}





