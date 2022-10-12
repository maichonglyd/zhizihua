import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

class GameNewRoundListState implements Cloneable<GameNewRoundListState> {
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();
  List<Game> gameList = [];
  int type;

  @override
  GameNewRoundListState clone() {
    return GameNewRoundListState()
      ..refreshHelper
      ..refreshHelper
      ..refreshHelperController = refreshHelperController
      ..gameList = gameList
      ..type = type;
  }
}

GameNewRoundListState initState(int type) {
  return GameNewRoundListState()..type = type;
}
