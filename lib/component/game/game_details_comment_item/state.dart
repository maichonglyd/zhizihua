import 'package:fish_redux/fish_redux.dart';

import 'package:flutter_huoshu_app/model/game/game_comments.dart'
    as game_comments;

class GameCommentItemState implements Cloneable<GameCommentItemState> {
  game_comments.Comment comment;
  num gameId;

  @override
  GameCommentItemState clone() {
    return GameCommentItemState()
      ..comment = comment
      ..gameId = gameId;
  }
}

GameCommentItemState initState(game_comments.Comment comment, num gameId) {
  return GameCommentItemState()
    ..comment = comment
    ..gameId = gameId;
}
