import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GameRewardListState implements Cloneable<GameRewardListState> {
  String videoType;
  List<Game> games;
  RefreshController refreshController =
  RefreshController(initialRefresh: false);

  @override
  GameRewardListState clone() {
    return GameRewardListState()
      ..videoType = videoType
      ..games = games
      ..refreshController = refreshController;
  }
}

GameRewardListState initState(String videoType, GameSpecial gameSpecial) {
  return GameRewardListState()
    ..videoType = videoType
    ..games = gameSpecial.gameList;
}
