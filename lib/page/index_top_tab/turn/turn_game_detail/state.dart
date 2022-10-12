import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_detail_model.dart';

class TurnGameDetailState implements Cloneable<TurnGameDetailState> {
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();

  num activityId;
  TurnGameDetailModel turnGameDetailModel;
  bool isHas = false;

  @override
  TurnGameDetailState clone() {
    return TurnGameDetailState()
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController
      ..activityId = activityId
      ..turnGameDetailModel = turnGameDetailModel
      ..isHas = isHas;
  }
}

TurnGameDetailState initState(Map<String, dynamic> args) {
  return TurnGameDetailState()..activityId = args['activityId'];
}
