import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/gift/game_gifts_bean.dart';

class GiftListFragmentState implements Cloneable<GiftListFragmentState> {
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();
  List<Gift> gifts = List();
  int gameId;

  @override
  GiftListFragmentState clone() {
    return GiftListFragmentState()
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController
      ..gifts = gifts
      ..gameId = gameId;
  }
}

GiftListFragmentState initState(Map<String, dynamic> args) {
  return GiftListFragmentState()
    ..gifts = List()
    ..gameId = null != args['gameId'] ? args['gameId'] : null;
}
