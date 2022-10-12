import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GameFirstRoundState implements Cloneable<GameFirstRoundState> {
  String videoType;
  List<Game> games = [];
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  GameFirstRoundState clone() {
    return GameFirstRoundState()
      ..videoType = videoType
      ..games = games
      ..refreshController = refreshController;
  }
}

GameFirstRoundState initState(String videoType, GameSpecial gameSpecial) {
  HuoVideoManager.add(HuoVideoViewExt(videoType,));
  return GameFirstRoundState()
    ..videoType = videoType
    ..games = gameSpecial.gameList;
}
