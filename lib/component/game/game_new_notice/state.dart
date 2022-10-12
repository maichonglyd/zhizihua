import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GameNewNoticeState implements Cloneable<GameNewNoticeState> {
  String videoType;
  List<Game> games = [];
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  String type;

  @override
  GameNewNoticeState clone() {
    return GameNewNoticeState()
      ..videoType = videoType
      ..games = games
      ..refreshController = refreshController
      ..type = type;
  }
}

GameNewNoticeState initState(
    String videoType, String type, GameSpecial gameSpecial) {
  HuoVideoManager.add(HuoVideoViewExt(videoType,));
  return GameNewNoticeState()
    ..videoType = videoType
    ..games = gameSpecial.gameList
    ..type = type;
}
