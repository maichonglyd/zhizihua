import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/component/classify/model/classify_mod.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ClassifyState implements Cloneable<ClassifyState> {
  List<GameClassifyType> tabs;
  List<Game> games = [];
  int selectTypeId = 0;
  String videoType;
  int page = 1;

  //游戏类别封面
  String typeImageCover;

  //第一个游戏的id
  int gameId;
  Game game;
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  ClassifyState clone() {
    return ClassifyState()
      ..tabs = tabs
      ..refreshHelper = refreshHelper
      ..selectTypeId = selectTypeId
      ..typeImageCover = typeImageCover
      ..refreshHelperController = refreshHelperController
      ..gameId = gameId
      ..game = game
      ..games = games
      ..videoType = videoType
      ..refreshController = refreshController
      ..page = page;
  }
}

ClassifyState initState(String videoType) {
  HuoVideoManager.add(new HuoVideoViewExt(videoType));
  return ClassifyState()..videoType = videoType;
//    ..tabs = List()
//    ..games = List();
}
