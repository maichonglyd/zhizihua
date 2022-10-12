import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

class SingleGameListState implements Cloneable<SingleGameListState> {
  List<Game> games;
  RefreshHelperController refreshHelperController = RefreshHelperController();
  RefreshHelper refreshHelper = RefreshHelper();

  @override
  SingleGameListState clone() {
    return SingleGameListState()
      ..games = games
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController;
  }
}

SingleGameListState initState() {
  //这里games必须得初始化，不然会报空
  return SingleGameListState()..games = List();
}
