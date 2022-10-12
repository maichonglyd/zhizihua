import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/gift/game_gifts_bean.dart';

class MyGiftState implements Cloneable<MyGiftState> {
  List<Gift> gifts;
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();

  @override
  MyGiftState clone() {
    return MyGiftState()
      ..gifts = gifts
      ..refreshHelperController = refreshHelperController
      ..refreshHelper = refreshHelper;
  }
}

MyGiftState initState(Map<String, dynamic> args) {
  return MyGiftState()..gifts = List();
}
