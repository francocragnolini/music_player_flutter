import "package:flutter/material.dart";

class AudioPlayerModel with ChangeNotifier {
  bool playing = false;

  late AnimationController _controller;

  set controller(AnimationController valor) {
    this._controller = valor;
  }

  AnimationController get controller => this._controller;
}
