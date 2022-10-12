import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_comments.dart';
import 'package:flutter_huoshu_app/model/game/game_details.dart';

class GameCommunityState implements Cloneable<GameCommunityState> {
  CommentStar starCnt; //10分5星制
  num gameId;
  List<Comment> comments = List();

  @override
  GameCommunityState clone() {
    return GameCommunityState()
      ..starCnt = starCnt
      ..gameId = gameId
      ..comments = comments;
  }
}

GameCommunityState initState(
    CommentStar starCnt, num gameId) {
  return GameCommunityState()
    ..starCnt = starCnt
    ..gameId = gameId
    ..comments = [];
}
