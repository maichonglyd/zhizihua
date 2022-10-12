import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_details.dart';

class GameCommentHeadState implements Cloneable<GameCommentHeadState> {
  CommentStar starCnt; //10分5星制
  int gameId;
  @override
  GameCommentHeadState clone() {
    return GameCommentHeadState()
      ..starCnt = starCnt
      ..gameId = gameId;
  }
}

GameCommentHeadState initState(CommentStar starCnt, int gameId) {
  return GameCommentHeadState()
    ..starCnt = starCnt
    ..gameId = gameId;
}
