import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter_huoshu_app/model/game/game_details.dart';
import 'package:flutter_huoshu_app/model/game/new_list.dart';
import 'package:video_player/video_player.dart';

//TODO replace with your own action
enum GameDetailsImagesAction {
  action,
  gotoGallery,
  createController,
  createPlayController,
  updatePlayStatus,
  updateVideoData,
  updateImages,
  changeVideoState,
  changeVideoVolume,
  updateVideoVolumeIcon
}

class GameDetailsImagesActionCreator {
  static Action onAction() {
    return const Action(GameDetailsImagesAction.action);
  }

  static Action gotoGallery(int index) {
    return Action(GameDetailsImagesAction.gotoGallery, payload: index);
  }

  static Action changeVideoVolume() {
    return const Action(GameDetailsImagesAction.changeVideoVolume);
  }

  static Action updateVideoVolumeIcon() {
    return const Action(GameDetailsImagesAction.updateVideoVolumeIcon);
  }

  static Action changeVideoState() {
    return const Action(GameDetailsImagesAction.changeVideoState);
  }

  static Action updatePlayStatus() {
    return Action(GameDetailsImagesAction.updatePlayStatus);
  }

  static Action updateVideoData(List<New> list) {
    return Action(GameDetailsImagesAction.updateVideoData, payload: list);
  }

  static Action updateImages(List<ImageMod> list) {
    return Action(GameDetailsImagesAction.updateImages, payload: list);
  }

  static Action onCreateController(ScrollController scrollController) {
    return Action(GameDetailsImagesAction.createController,
        payload: {"scrollController": scrollController});
  }

  static Action onCreatePlayController(
      VideoPlayerController videoPlayerController) {
    return Action(GameDetailsImagesAction.createPlayController,
        payload: videoPlayerController);
  }
}
