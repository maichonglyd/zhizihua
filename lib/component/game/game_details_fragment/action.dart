import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter_huoshu_app/model/game/game_comments.dart'
    as game_comments;
import 'package:video_player/video_player.dart';
//TODO replace with your own action

enum GameDetailsAction {
  action,
  getComments,
  updateComments,
  createPlayController,
  createController
}

class GameDetailsActionCreator {
  static Action onAction() {
    return const Action(GameDetailsAction.action);
  }

  static Action getComments() {
    return const Action(GameDetailsAction.getComments);
  }

  static Action updateComments(List<game_comments.Comment> comments) {
    return Action(GameDetailsAction.updateComments, payload: comments);
  }

  static Action onCreateController(ScrollController scrollController) {
    return Action(GameDetailsAction.createController,
        payload: {"scrollController": scrollController});
  }

  static Action onCreatePlayController(
      VideoPlayerController videoPlayerController) {
    return Action(GameDetailsAction.createPlayController,
        payload: videoPlayerController);
  }
}
