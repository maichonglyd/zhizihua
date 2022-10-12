import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game_curr/game_curr_bean.dart';

class GameCurrencyListState implements Cloneable<GameCurrencyListState> {
  List<GameCurrBean> games = [];
  RefreshHelperController refreshHelperController = RefreshHelperController();
  RefreshHelper refreshHelper = RefreshHelper();

  @override
  GameCurrencyListState clone() {
    return GameCurrencyListState()
      ..games = games
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController;
  }
}

GameCurrencyListState initState(Map<String, dynamic> args) {
  return GameCurrencyListState()..games = List();
}
