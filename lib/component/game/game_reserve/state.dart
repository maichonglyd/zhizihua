import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

class GameReserveState implements Cloneable<GameReserveState> {
  RefreshHelper refreshHelper;
  RefreshHelperController refreshHelperController;
  List<Game> games;
  int isBT = 0;
  int isZK = 0;
  int isH5 = 0;

  @override
  GameReserveState clone() {
    return GameReserveState()
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController
      ..isH5 = isH5
      ..isBT = isBT
      ..isZK = isZK
      ..games = games;
  }
}

GameReserveState initState(Map<String, dynamic> args) {
  return GameReserveState()
    ..isBT = args["isBT"]
    ..isZK = args["isZK"]
    ..isH5 = args["isH5"]
    ..refreshHelperController = RefreshHelperController()
    ..refreshHelper = RefreshHelper()
    ..games = List();
}
