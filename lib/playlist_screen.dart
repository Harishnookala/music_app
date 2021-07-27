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
  bool playing = true;
  IconData play_button = Icons.pause;
  AudioPlayer _player;
  AudioCache _cache;
  String file;
  Duration position = new Duration();
  Duration music_length = new Duration();

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
    _player = AudioPlayer();
    _cache = AudioCache(fixedPlayer: _player);
    _player.play(widget.file);
  }

  @override
  Widget build(BuildContext context) {
    int tracks = int.parse(widget.number_of_songs);
    print(widget.index_of_song);
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
                        if (index == 0)
                          Container(
                            margin: EdgeInsets.only(left: 5.3, right: 5.3),
                            padding: EdgeInsets.only(top: 13.3, bottom: 15.3),
                            child: Center(
                              child: ClipRect(
                                clipBehavior: Clip.hardEdge,
                                child: (display_songs.albumArtwork != null)
                                    ? Image(
                                        image: FileImage(
                                            File(display_songs.albumArtwork)))
                                    : Image.asset("Images/music_tone.jpg"),
                              ),
                            ),
                          )
                        else
                          Container(),
                        (index == 0)
                            ? Center(
                                child: Text(widget
                                    .songs[widget.index_of_song].displayName),
                              )
                            : Container(),
                        (index == 0)
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                        setState(() {
                                          play_button = Icons.play_arrow;
                                          playing = false;
                                        });
                                      } else {
                                        _player.pause();
                                        setState(() {
                                          play_button = Icons.pause;
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
                              )
                            : Container(),
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
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        //margin: EdgeInsets.all(12.3),
                                        child: ListTile(
                                          title: Text(
                                              widget.songs[index].displayName),
                                          onTap: () {},
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
}
