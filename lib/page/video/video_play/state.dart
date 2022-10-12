import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:video_player/video_player.dart';

class VideoPlayState implements Cloneable<VideoPlayState> {
  VideoPlayerController videoPlayerController;

  // ignore: cancel_subscriptions
  StreamSubscription eventBus;
  Game game;

  @override
  VideoPlayState clone() {
    return VideoPlayState()
      ..videoPlayerController = videoPlayerController
      ..game = game;
  }
}

VideoPlayState initState(Map<String, dynamic> args) {
  return VideoPlayState()
    ..game = args["game"]
    ..videoPlayerController = args["controller"];
}
