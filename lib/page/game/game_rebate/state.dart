import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/game/new_list.dart';

class GameRebateState implements Cloneable<GameRebateState> {
  num gameId;
  List<New> rebateGames = [];
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();

  @override
  GameRebateState clone() {
    return GameRebateState()
      ..gameId = gameId
      ..rebateGames = rebateGames
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController;
  }
}

GameRebateState initState(Map<String, dynamic> args) {
  return GameRebateState()..gameId = args['gameId'];
}
