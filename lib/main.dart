import 'package:flutter/material.dart';
import 'package:music_player/src/models/audioplayer_model.dart';
import 'package:music_player/src/pages/music_player_page.dart';
import 'package:music_player/src/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => new AudioPlayerModel(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Music Player',
        theme: miTema,
        home: MusicPlayerPage());
  }
}
