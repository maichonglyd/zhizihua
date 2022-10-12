import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameDetailsImagesState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameDetailsImagesState>>{
      GameDetailsImagesAction.action: _onAction,
      GameDetailsImagesAction.createController: _createController,
      GameDetailsImagesAction.createPlayController: _createPlayController,
      GameDetailsImagesAction.updatePlayStatus: updatePlayStatus,
      GameDetailsImagesAction.updateVideoData: _updateVideoData,
      GameDetailsImagesAction.updateImages: updateImages,
      GameDetailsImagesAction.changeVideoState: _changeVideoState,
      GameDetailsImagesAction.updateVideoVolumeIcon: _updateVideoVolumeIcon,
    },
  );
}

GameDetailsImagesState _updateVideoVolumeIcon(
    GameDetailsImagesState state, Action action) {
  final GameDetailsImagesState newState = state.clone();
  if (newState.videoPlayerController.value.volume == 1) {
    newState.hasVolume = true;
  } else {
    newState.hasVolume = false;
  }
  print("hasVolume${newState.hasVolume}");
  return newState;
}

GameDetailsImagesState _changeVideoState(
    GameDetailsImagesState state, Action action) {
  final GameDetailsImagesState newState = state.clone();
  if (newState.videoPlayerController.value.isPlaying) {
    newState.videoPlayerController.pause();
  } else {
    newState.videoPlayerController.play();
  }
  return newState;
}

GameDetailsImagesState updatePlayStatus(
    GameDetailsImagesState state, Action action) {
  final GameDetailsImagesState newState = state.clone();
  newState.isPlay = !newState.isPlay;
  return newState;
}

GameDetailsImagesState updateImages(
    GameDetailsImagesState state, Action action) {
  final GameDetailsImagesState newState = state.clone();
  newState.images = action.payload;
  return newState;
}

GameDetailsImagesState _updateVideoData(
    GameDetailsImagesState state, Action action) {
  final GameDetailsImagesState newState = state.clone();
  newState.news = action.payload;
  return newState;
}

GameDetailsImagesState _createPlayController(
    GameDetailsImagesState state, Action action) {
  print("GameDetailsState:_createPlayController");
  final GameDetailsImagesState newState = state.clone();
  newState.videoPlayerController = action.payload;
  return newState;
}

GameDetailsImagesState _createController(
    GameDetailsImagesState state, Action action) {
  final GameDetailsImagesState newState = state.clone();
  newState.scrollController = action.payload['scrollController'];
  return newState;
}

GameDetailsImagesState _onAction(GameDetailsImagesState state, Action action) {
  final GameDetailsImagesState newState = state.clone();
  return newState;
}
