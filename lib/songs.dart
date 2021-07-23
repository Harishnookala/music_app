import 'dart:core';
import 'dart:io';
import 'package:flutter/cupertino.dart';

import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'widget.dart';

class SongWidget extends StatelessWidget {
  final List<SongInfo> songList;
  SongWidget({@required this.songList});
  List albums =[];
  @override
  Widget build(BuildContext context) {
    find_albums(songList);

    return ListView.builder(
      itemCount: songList.length,
      itemBuilder: (context, Index) {
        List<SongInfo> song = songList;

        if (song[Index].displayName.contains(".mp3")) {
          return Container(
              margin: EdgeInsets.all(2.3),
              child: new Card(
                child: Row(
                  children: [
                    ClipOval(
                      child: Image(
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        image: song[Index].albumArtwork!=null?FileImage(File(song[Index].albumArtwork)):AssetImage("Images/music_tone.jpg"),
                      ),

                    ),
                    Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top:16.3,left: 16.3,bottom: 16.3),
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
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                child: Text("Album_Id: ${song[Index].albumId}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500)),
                              ),

                            ],
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.all(16.3),
                      child: InkWell(
                        onTap: () {
                          audioManagerInstance
                              .start("file://${song[Index].filePath}", song[Index].title,
                              desc: song[Index].displayName,
                              auto: true,
                              cover: song[Index].albumArtwork)
                              .then((err) {

                          });
                        },
                        child: IconText(
                          iconData: Icons.play_circle_outline,
                          iconColor: Colors.red,
                          string: "Play",
                          textColor: Colors.black,
                          iconSize: 25,
                        ),
                      ),
                    )
                  ],
                ),
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

  List find_albums(List<SongInfo> song) {
    for (int i = 0;i<song.length;i++){
      print(song[i].album +song[i].title);

      if(albums.contains(song[i].album)){
         print("");
       }
       else{
         albums.add(song[i].album);
       }
    }



  }



}




class Songs{
  String album_name;
  String title;

  Songs({this.album_name,this.title});
}





