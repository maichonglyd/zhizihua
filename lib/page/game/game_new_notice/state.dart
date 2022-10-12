import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GameNewNoticeState implements Cloneable<GameNewNoticeState> {
  String videoType;
  List<Game> games = [];
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  int page = 1;
  String title;
  int specialId;

  @override
  GameNewNoticeState clone() {
    return GameNewNoticeState()
      ..videoType = videoType
      ..games = games
      ..refreshController = refreshController
      ..page = page
      ..title = title
      ..specialId = specialId;
  }
}

GameNewNoticeState initState(Map<String, dynamic> args) {
  HuoVideoManager.add(HuoVideoViewExt(HuoVideoManager.type_other, active: true));
  return GameNewNoticeState()
    ..videoType = HuoVideoManager.type_other
    ..title = args["title"]
    ..specialId = args["specialId"];
}
