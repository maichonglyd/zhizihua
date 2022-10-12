import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_special_list.dart';

class GameSpecialPageState implements Cloneable<GameSpecialPageState> {
  String title;
  int specialId;
  List<Game> games;
  TopicData topicData;

  RefreshHelper refreshHelper;
  RefreshHelperController refreshHelperController;

  @override
  GameSpecialPageState clone() {
    return GameSpecialPageState()
      ..title = title
      ..specialId = specialId
      ..games = games
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController
      ..topicData = topicData;
  }
}

GameSpecialPageState initState(Map<String, dynamic> map) {
  return GameSpecialPageState()
    ..title = map["title"]
    ..specialId = map["specialId"]
    ..games = List()
    ..refreshHelperController = RefreshHelperController()
    ..refreshHelper = RefreshHelper();
}
