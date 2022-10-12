import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_index_data.dart';

class PropDealSelectGameState implements Cloneable<PropDealSelectGameState> {
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();
  List<PlayedGame> games;

  @override
  PropDealSelectGameState clone() {
    return PropDealSelectGameState()
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController
      ..games = games;
  }
}

PropDealSelectGameState initState(Map<String, dynamic> args) {
  return PropDealSelectGameState()..games = List();
}
