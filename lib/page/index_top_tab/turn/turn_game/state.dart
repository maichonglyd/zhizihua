import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_data.dart';

class TurnGameState implements Cloneable<TurnGameState> {
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();
  List<TurnGameBean> list = [];

  @override
  TurnGameState clone() {
    return TurnGameState()
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController
      ..list = list;
  }
}

TurnGameState initState(Map<String, dynamic> args) {
  return TurnGameState();
}
