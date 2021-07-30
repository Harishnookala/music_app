import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class Player extends StatefulWidget {
  int index_of_song;
  List<SongInfo> songs;
  String file;
  String number_of_songs;

  Player({this.songs, this.file, this.number_of_songs, this.index_of_song});

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  bool playing = false;
  AudioPlayer _player;
  AudioCache _cache;
  String file;
  Duration position = new Duration();
  Duration music_length = new Duration();
  IconData play_button = Icons.pause;

  Widget slider() {
    return Slider.adaptive(
        value: position.inSeconds.toDouble(),
        activeColor: Colors.blue[800],
        inactiveColor: Colors.grey[600],
        max: music_length.inSeconds.toDouble(),
        onChanged: (value) {
          seektoSec(value.toInt());
        });
  }

  void seektoSec(int value) {
    Duration newPos = Duration(seconds: value);

    _player.seek(newPos);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cache = AudioCache(fixedPlayer: _player);
    _player = AudioPlayer();

    _player.durationHandler = (d) {
      setState(() {
        music_length = d;
      });
    };
    _player.positionHandler = (p) {
      setState(() {
        position = p;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    int tracks = int.parse(widget.number_of_songs);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(15.3),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: tracks,
            itemBuilder: (context, index) {
              SongInfo display_songs = widget.songs[index];
              return new Container(
                child: Column(
                  children: [
                    Column(
                      children: [
                        (index == 0)
                            ? Container(
                                margin: EdgeInsets.only(left: 5.3, right: 5.3),
                                padding:
                                    EdgeInsets.only(top: 13.3, bottom: 15.3),
                                child: Center(
                                  child: ClipRect(
                                    clipBehavior: Clip.hardEdge,
                                    child: (display_songs.albumArtwork != null)
                                        ? Image(
                                            image: FileImage(File(
                                                display_songs.albumArtwork)))
                                        : Image.asset("Images/music_tone.jpg"),
                                  ),
                                ),
                              )
                            : Container(),
                        (index == 0)
                            ? Container(
                                child: Text(
                                  widget
                                      .songs[widget.index_of_song].displayName,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.cyan),
                                ),
                              )
                            : Container(),
                        (index == 0)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${position.inMinutes}:${position.inSeconds.remainder(60)}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  slider(),
                                  Text(
                                      "${music_length.inMinutes}:${music_length.inSeconds.remainder(60)}",
                                      style: TextStyle(fontSize: 16)),
                                ],
                              )
                            : Container(),
                        (index == 0) ? build_play_widget() : Container(),
                        Container(
                          margin: EdgeInsets.all(12.3),
                          // decoration: BoxDecoration(border: Border.all(color: Colors.deepOrangeAccent)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    ClipOval(
                                      child: (display_songs.albumArtwork !=
                                              null)
                                          ? Image(
                                              width: 40,
                                              height: 40,
                                              image: FileImage(File(
                                                  display_songs.albumArtwork)))
                                          : Image.asset(
                                              "Images/music_tone.jpg"),
                                    ),
                                    Container(
                                        width:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width *
                                            0.7,
                                        //margin: EdgeInsets.all(12.3),
                                        child: ListTile(
                                          title: Text(
                                              widget.songs[index].displayName),
                                          onTap: () {
                                            setState(() {
                                              widget.index_of_song = index;
                                              widget.file =
                                                  widget.songs[index].filePath;
                                            });
                                            _player.play(widget.file);
                                          },
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  build_play_widget() {
    _player.play(widget.file);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          child: Icon(
            Icons.skip_previous_outlined,
            color: Colors.blue,
            size: 45,
          ),
          onTap: () {},
        ),
        TextButton(
          child: Icon(
            play_button,
            color: Colors.green,
            size: 35,
          ),
          onPressed: () {
            if (playing) {
              _player.play(widget.file);
              setState(() {
                play_button = Icons.pause;
                playing = false;
              });
            } else {
              _player.stop();
              setState(() {
                play_button = Icons.play_arrow;
                playing = true;
              });
            }
          },
        ),
        InkWell(
          child: Icon(
            Icons.skip_next_outlined,
            color: Colors.blue,
            size: 35,
          ),
          onTap: () {},
        )
      ],
    );
  }
}
