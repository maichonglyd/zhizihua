import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game_curr/game_curr_bean.dart';

//TODO replace with your own action
enum GameCurrencyListAction {
  action,
  getGameCurrencyList,
  updateGameCurrencyList
}

class GameCurrencyListActionCreator {
  static Action onAction() {
    return const Action(GameCurrencyListAction.action);
  }

  static Action getGameCurrencyList(int page) {
    return Action(GameCurrencyListAction.getGameCurrencyList, payload: page);
  }

  static Action updateGameCurrencyList(List<GameCurrBean> games) {
    return Action(GameCurrencyListAction.updateGameCurrencyList,
        payload: games);
  }
}
