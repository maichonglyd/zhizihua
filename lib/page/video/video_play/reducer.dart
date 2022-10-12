import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<VideoPlayState> buildReducer() {
  return asReducer(
    <Object, Reducer<VideoPlayState>>{
      VideoPlayAction.action: _onAction,
      VideoPlayAction.changeVideoState: _changeVideoState,
    },
  );
}

VideoPlayState _onAction(VideoPlayState state, Action action) {
  final VideoPlayState newState = state.clone();
  return newState;
}

VideoPlayState _changeVideoState(VideoPlayState state, Action action) {
  final VideoPlayState newState = state.clone();
  if (newState.videoPlayerController.value.isPlaying) {
    newState.videoPlayerController.pause();
  } else {
    newState.videoPlayerController.play();
  }
  return newState;
}
