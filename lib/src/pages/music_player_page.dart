import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:music_player/src/models/audioplayer_model.dart';
import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:music_player/src/helpers/helpers.dart';

import 'package:music_player/src/widgtes/custom_appbar.dart';

class MusicPlayerPage extends StatelessWidget {
  const MusicPlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Background(),
        Column(children: [
          CustomAppbar(),
          ImagenDiscoDuracion(),
          TituloPlay(),
          Expanded(child: Lyrics())
        ]),
      ]),
    );
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: screenSize.height * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.center,
              colors: [
                Color(0xff33333E),
                Color(0xff201E28),
              ])),
    );
  }
}

class Lyrics extends StatelessWidget {
  final lyrics = getLyrics();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListWheelScrollView(
        physics: BouncingScrollPhysics(),
        itemExtent: 42,
        diameterRatio: 1.5,
        children: lyrics
            .map(
              (item) => Text(
                item,
                style: TextStyle(
                    fontSize: 20, color: Colors.white.withOpacity(0.6)),
              ),
            )
            .toList(),
      ),
    );
  }
}

class TituloPlay extends StatefulWidget {
  @override
  State<TituloPlay> createState() => _TituloPlayState();
}

class _TituloPlayState extends State<TituloPlay>
    with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  bool firstTime = true;
  AnimationController? playAnimation;

  @override
  void initState() {
    // TODO: implement initState

    playAnimation =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    this.playAnimation!.dispose();
    super.dispose();
  }

///////////////////////////////////
  //Metodo

  //Funcion de Fernando
  /*void open() {
    final audioPlayerModel =
        Provider.of<AudioPlayerModel>(context, listen: false);

    //! assetAudioPlayer.open('assets/Breaking-Benjamin-Far-Away.mp3');
    assetAudioPlayer.open(Audio('assets/Breaking-Benjamin-Far-Away.mp3'),
        autoStart: true, showNotification: true);

    assetAudioPlayer.currentPosition.listen((duration) {
      audioPlayerModel.current = duration;
    });

    assetAudioPlayer.current.listen((playingAudio) {
      //! audioPlayerModel.songDuration = playingAudio.duration;
      audioPlayerModel.songDuration =
          playingAudio?.audio.duration ?? Duration(seconds: 0);
    });
  }*/

  //Documentacion
  //no esta implementada en el codigo
  void open() {
    final audioPlayerModel =
        Provider.of<AudioPlayerModel>(context, listen: false);

    final assetsAudioPlayer = AssetsAudioPlayer();

    assetsAudioPlayer.open(
      Audio("assets/audios/song1.mp3"),
    );
  }

//////////////////////
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      margin: EdgeInsets.only(top: 40),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                "Far Away",
                style: TextStyle(
                    fontSize: 30, color: Colors.white.withOpacity(0.8)),
              ),
              Text(
                "breaking benjamin",
                style: TextStyle(
                    fontSize: 15, color: Colors.white.withOpacity(0.5)),
              ),
            ],
          ),
          Spacer(),
          FloatingActionButton(
            elevation: 0,
            highlightElevation: 0,
            onPressed: () {
              // conectado el disco con este boton a traves de provider
              final audioPlayerModel =
                  Provider.of<AudioPlayerModel>(context, listen: false);
              //TODO: boton: hacer que gire el disco
              if (this.isPlaying) {
                playAnimation!.reverse();
                this.isPlaying = false;
                audioPlayerModel.controller.stop();
              } else {
                playAnimation!.forward();
                this.isPlaying = true;
                audioPlayerModel.controller.repeat();
              }
            },
            backgroundColor: Color(0xffF8CB51),
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: playAnimation!,
            ),
          )
        ],
      ),
    );
  }
}

class ImagenDiscoDuracion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.only(top: 70),
      child: Row(children: [
        ImagenDisco(),
        SizedBox(
          width: 20,
        ),
        //TODO:BARRA PROGRESO
        BarraProgreso(),
        SizedBox(
          width: 20,
        ),
      ]),
    );
  }
}

class BarraProgreso extends StatelessWidget {
  final estilo = TextStyle(color: Colors.white.withOpacity(0.4));

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            "00:00",
            style: estilo,
          ),
          SizedBox(
            height: 10,
          ),
          Stack(
            children: [
              Container(
                width: 3,
                height: 230,
                color: Colors.white.withOpacity(0.1),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: 3,
                  height: 100,
                  color: Colors.white.withOpacity(0.8),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "00:00",
            style: estilo,
          ),
        ],
      ),
    );
  }
}

class ImagenDisco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);

    return Container(
      padding: EdgeInsets.all(20),
      width: 250,
      height: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [Color(0xff484750), Color(0xff1E1C724)])),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SpinPerfect(
                duration: Duration(seconds: 10),
                controller: (animationController) =>
                    audioPlayerModel.controller = animationController,
                manualTrigger: true,
                infinite: true,
                child: Image(
                  image: AssetImage("assets/aurora.jpg"),
                ),
              ),
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(100)),
              ),
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                    color: Color(0xff1C1C25),
                    borderRadius: BorderRadius.circular(100)),
              )
            ],
          )),
    );
  }
}
