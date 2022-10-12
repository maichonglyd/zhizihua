import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_goods.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/repository/deal_history_repository.dart';

//TODO replace with your own action
enum GameSearchAction {
  action,
  select,
  updateHistory,
  clear,
  updateDealGoodsList
}

class GameSearchActionCreator {
  static Action onAction() {
    return const Action(GameSearchAction.action);
  }

  static Action clear() {
    return const Action(GameSearchAction.clear);
  }

  static Action select() {
    return const Action(GameSearchAction.select);
  }

  static Action updateHistory(List<DealHistory> updateHistory) {
    return Action(GameSearchAction.updateHistory, payload: updateHistory);
  }

  static Action updateDealGoodsList(List<DealGoods> dealGoods) {
    return Action(GameSearchAction.updateDealGoodsList, payload: dealGoods);
  }
}
