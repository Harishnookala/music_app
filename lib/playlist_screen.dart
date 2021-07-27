import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/widget.dart';

class Player extends StatefulWidget {
  int index;

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  bool playing = false;
  IconData play_button = Icons.play_arrow;
  AudioPlayer _player;
  AudioCache _cache;
  Duration position = new Duration();
  Duration music_length = new Duration();

  Widget slider() {
    return Slider.adaptive(value: position.inSeconds.toDouble(),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              child: ClipRect(
                child: Image(
                  height: 290,
                  width: 290,
                  image: AssetImage("Images/music_tone.jpg"),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.all(15.3),
                child: slider()
            ),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: Icon(
                      Icons.skip_previous_outlined, color: Colors.blue,
                      size: 45,),
                    onTap: () {

                    },
                  ),
                  InkWell(
                    child: Icon(play_button, color: Colors.green, size: 35,),
                    onTap: () {
                      if (!playing) {
                        setState(() {
                          play_button = Icons.pause;
                          playing = true;
                        });
                      } else {
                        setState(() {
                          play_button = Icons.play_arrow;
                          playing = false;
                        });
                      }
                    },
                  ),
                  InkWell(
                    child: Icon(
                      Icons.skip_next_outlined, color: Colors.blue, size: 35,),
                    onTap: () {

                    },
                  )
                ],
              ),
            )

          ],
        ),
      ),
    );
  }

}



