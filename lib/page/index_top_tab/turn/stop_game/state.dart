import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_data.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_stop_model.dart';

class StopGameState implements Cloneable<StopGameState> {
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();

  List<TurnGameStopBean> list = [];
  num activityId;
  TurnGame game;

  @override
  StopGameState clone() {
    return StopGameState()
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController
      ..list = list
      ..activityId = activityId
      ..game = game;
  }
}

StopGameState initState(Map<String, dynamic> args) {
  return StopGameState()
    ..activityId = args['activityId']
    ..game = args['game'];
}
