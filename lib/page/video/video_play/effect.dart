import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/page/video/video_play/page.dart';
import 'action.dart';
import 'state.dart';

Effect<VideoPlayState> buildEffect() {
  return combineEffects(<Object, Effect<VideoPlayState>>{
    Lifecycle.didChangeDependencies: _onDidChangeDependencies,
    Lifecycle.dispose: _dispose,
  });
}

@override
void _onDidChangeDependencies(Action action, Context<VideoPlayState> ctx) {
  if (ModalRoute.of(ctx.context).isCurrent == true) {
    ctx.state.videoPlayerController.play();
  } else {
    ctx.state.videoPlayerController.pause();
  }
}

void _dispose(Action action, Context<VideoPlayState> ctx) {
  VideoPlayPage.isCurrent = false;
}
