import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_gift_model.dart';

class TurnGiftState implements Cloneable<TurnGiftState> {
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();
  List<TurnGiftBean> list = [];

  @override
  TurnGiftState clone() {
    return TurnGiftState()
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController
      ..list = list;
  }
}

TurnGiftState initState(Map<String, dynamic> args) {
  return TurnGiftState();
}
