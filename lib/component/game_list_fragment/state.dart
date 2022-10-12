import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

class GameListState implements Cloneable<GameListState> {
  //页面类型
  static const int TYPE_PAGE_KF = 1;
  static const int TYPE_PAGE_CLASSIFY = 2;
  static const int TYPE_PAGE_RANK = 3;

  //游戏类型,TYPE_HT表示手游
  static const int TYPE_HT = 0;
  static const int TYPE_BT = 1;
  static const int TYPE_ZK = 2;
  static const int TYPE_H5 = 3;
  static const int TYPE_ALL = 4;

  //开服下的时间类型
  static const int TYPE_KF_TODAY = 1;
  static const int TYPE_KF_NEW = 2;
  static const int TYPE_KF_OLD = 3;

  int type; //用于加载游戏数据
  int pageType; //用于加载页面类型
  int kfType; // 开服下的今日,即将，历史
  int tagId; //分类下的标签

  List<Game> games;

  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();

  @override
  GameListState clone() {
    return GameListState()
      ..games = games
      ..pageType = pageType
      ..type = type
      ..tagId = tagId
      ..kfType = kfType
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController;
  }
}

GameListState initState(int pageType, int type, {kfType = 1}) {
  return GameListState()
    ..pageType = pageType
    ..type = type
    ..kfType = kfType
    ..tagId = 0
    ..refreshHelperController = RefreshHelperController()
    ..refreshHelper = RefreshHelper()
    ..games = List();
}
