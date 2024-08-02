




import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Home extends StatefulWidget{
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final player=AudioPlayer();


  String formatDuration(Duration d){


    final minutes=d.inMinutes.remainder(60);
    final second=d.inSeconds.remainder(60);


    return "${minutes.toString().padLeft(2,'0')}:${second.toString().padLeft(2,'0')}";

  }


  void handlePlayPause(){
    if(player.playing){
      player.pause();
    }
    else{
      player.play();
    }
  }

  void handleSeek(double value){

    player.seek(Duration(seconds: value.toInt()));
    super.initState();


  }

  Duration position=Duration.zero;
  Duration duration=Duration.zero;

  @override
  void initState() {
    super.initState();

    player.setUrl("https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3");

    player.positionStream.listen((p){

      setState(() {
        position=p;
      });
    });



    player.durationStream.listen((d){
      setState(() {
        duration=d!;
      });
    });


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(


      appBar: AppBar(
        title: Text('test'),
      ),
      body: Column(
        children: [
          Text(formatDuration(position)),
          
          
          
          Slider(
            min: 0.0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: handleSeek
          ),


          Text(formatDuration(position)),


          IconButton(onPressed: handlePlayPause, icon: Icon(player.playing? Icons.pause:Icons.play_arrow))


        ],
      )
    );
  }
}